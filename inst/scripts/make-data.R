### =========================================================================
### make-data.R
### -------------------------------------------------------------------------
###
### Builds the TxDb SQLite database distributed with this package through
### AnnotationHub, using the official Rice Genome Annotation Project (RGAP)
### Release 7 / MSU7 GFF3 annotation and IRGSP-1.0 reference genome.
###
### GFF3 source:
### https://rice.uga.edu/pub/data/Eukaryotic_Projects/
###   o_sativa/annotation_dbs/pseudomolecules/version_7.0/all.dir/all.gff3
###
### FASTA source:
### https://rice.uga.edu/osa1r7_download/osa1_r7.asm.fa.gz
###
### The resulting file, TxDb.Osativa.MSU.RGAP7.sqlite, is deposited on Zenodo
### (record 23830226) and referenced from inst/extdata/metadata.csv.
###
### This script is for data preparation and provenance. It is not run during
### normal package installation or package checking.
###
### =========================================================================


# -------------------------------------------------------------------------
# Load required packages
# -------------------------------------------------------------------------

library(Biostrings)
library(GenomeInfoDb)
library(GenomicFeatures)
library(txdbmaker)
library(AnnotationDbi)


# -------------------------------------------------------------------------
# 1. Define paths and parameters
# -------------------------------------------------------------------------

# Official RGAP Release 7 GFF3 annotation
gff_url <- paste0(
    "https://rice.uga.edu/pub/data/Eukaryotic_Projects/",
    "o_sativa/annotation_dbs/pseudomolecules/version_7.0/all.dir/",
    "all.gff3"
)

# Official IRGSP-1.0 reference genome FASTA
fasta_url <- paste0(
    "https://rice.uga.edu/",
    "osa1r7_download/",
    "osa1_r7.asm.fa.gz"
)

# Input and output filenames
gff_file <- basename(gff_url)
fasta_file <- basename(fasta_url)
output_sqlite <- "TxDb.Osativa.MSU.RGAP7.sqlite"

# Organism information
organism_name <- "Oryza sativa"
taxonomy_id <- 4530
genome_assembly <- "IRGSP-1.0"


# -------------------------------------------------------------------------
# 2. Download reference annotation and genome files
# -------------------------------------------------------------------------

if (!file.exists(gff_file)) {
    download.file(
        gff_url,
        destfile = gff_file,
        mode = "wb"
    )
}

if (!file.exists(fasta_file)) {
    download.file(
        fasta_url,
        destfile = fasta_file,
        mode = "wb"
    )
}

# Verify that both input files exist and are non-empty
stopifnot(
    file.exists(gff_file),
    file.exists(fasta_file),
    file.info(gff_file)$size > 0,
    file.info(fasta_file)$size > 0
)

message("GFF3 and FASTA files are available.")


# -------------------------------------------------------------------------
# 3. Read reference genome FASTA
# -------------------------------------------------------------------------

genome_fasta <- Biostrings::readDNAStringSet(fasta_file)

if (is.null(names(genome_fasta))) {
    stop("FASTA sequence names must be present.")
}

# Retain only the sequence identifiers
names(genome_fasta) <- sub(
    "[[:space:]].*$",
    "",
    names(genome_fasta)
)

# Validate sequence identifiers
if (anyNA(names(genome_fasta)) ||
    any(names(genome_fasta) == "") ||
    anyDuplicated(names(genome_fasta))) {
    stop("FASTA sequence IDs must be non-empty and unique.")
}

# Extract sequence lengths
seq_lengths <- as.numeric(
    Biostrings::width(genome_fasta)
)

# Display reference genome information
fasta_summary <- data.frame(
    chromosome = names(genome_fasta),
    length = seq_lengths
)

print(fasta_summary)


# -------------------------------------------------------------------------
# 4. Construct chromosome information from FASTA
# -------------------------------------------------------------------------

# The supplied RGAP7 FASTA contains 12 nuclear chromosomes, unanchored
# sequences (ChrUn), and the Syngenta pseudomolecule (ChrSy).
# These 14 reference sequences are represented as linear sequences.

chrominfo <- GenomeInfoDb::Seqinfo(
    seqnames = names(genome_fasta),
    seqlengths = seq_lengths,
    isCircular = rep(FALSE, length(genome_fasta)),
    genome = rep(genome_assembly, length(genome_fasta))
)

print(chrominfo)


# -------------------------------------------------------------------------
# 5. Build the TxDb object from GFF3 annotation
# -------------------------------------------------------------------------

# txdbmaker may report source-annotation limitations during import:
# - some CDS phase values are missing or outside the permitted range (0-2);
# - 88 transcript models have one or more CDS features that cannot be mapped
#   to a corresponding exon under the importer's containment rules.
#
# Inspection identified 89 unmatched CDS features. The original GFF3
# coordinates are retained without manual modification. These warnings are
# not suppressed so that source-annotation issues remain visible.
#
# txdbmaker may also report that genome version information is unavailable
# while normalizing its internal chrominfo table. The genome assignment is
# checked on the resulting TxDb and again after saving and reloading below.

rice_txdb <- txdbmaker::makeTxDbFromGFF(
    file = gff_file,
    format = "gff3",
    dataSource = "Rice Genome Annotation Project (RGAP) Release 7",
    organism = organism_name,
    taxonomyId = taxonomy_id,
    chrominfo = chrominfo
)


# -------------------------------------------------------------------------
# 6. Validate the generated TxDb object
# -------------------------------------------------------------------------

rice_seqinfo <- GenomeInfoDb::seqinfo(rice_txdb)

print(rice_seqinfo)

# Verify genome assembly information
stopifnot(
    all(GenomeInfoDb::genome(rice_seqinfo) == genome_assembly)
)

# Verify sequence names
stopifnot(
    setequal(
        GenomeInfoDb::seqlevels(rice_txdb),
        names(genome_fasta)
    )
)

# Verify sequence lengths
stopifnot(
    all(
        GenomeInfoDb::seqlengths(rice_seqinfo)[names(genome_fasta)] ==
            seq_lengths
    )
)

# All sequences in the supplied reference FASTA are treated as linear
stopifnot(
    all(!GenomeInfoDb::isCircular(rice_seqinfo))
)

message("TxDb validation completed successfully.")


# -------------------------------------------------------------------------
# 7. Save the TxDb object as an SQLite database
# -------------------------------------------------------------------------

AnnotationDbi::saveDb(
    rice_txdb,
    file = output_sqlite
)

message(
    "TxDb SQLite database saved to: ",
    normalizePath(output_sqlite)
)


# -------------------------------------------------------------------------
# 8. Reload the SQLite database and perform final validation
# -------------------------------------------------------------------------

rice_txdb_check <- AnnotationDbi::loadDb(output_sqlite)

print(rice_txdb_check)

si <- GenomeInfoDb::seqinfo(rice_txdb_check)

print(si)

# Verify genome assembly after reloading
stopifnot(
    all(GenomeInfoDb::genome(si) == genome_assembly)
)

# Verify sequence names after reloading
stopifnot(
    setequal(
        GenomeInfoDb::seqlevels(rice_txdb_check),
        names(genome_fasta)
    )
)

# Verify sequence lengths after reloading
stopifnot(
    all(
        GenomeInfoDb::seqlengths(si)[names(genome_fasta)] ==
            seq_lengths
    )
)


# -------------------------------------------------------------------------
# 9. Display annotation statistics
# -------------------------------------------------------------------------

cat(
    "Number of transcripts:",
    length(GenomicFeatures::transcripts(rice_txdb_check)),
    "\n"
)

cat(
    "Number of exons:",
    length(GenomicFeatures::exons(rice_txdb_check)),
    "\n"
)

cat(
    "Number of genes:",
    length(GenomicFeatures::genes(rice_txdb_check)),
    "\n"
)

cat(
    "Number of reference sequences:",
    length(GenomeInfoDb::seqlevels(rice_txdb_check)),
    "\n"
)

cat(
    "Genome assembly:",
    genome_assembly,
    "\n"
)

cat("\nAll validation checks passed successfully.\n")
