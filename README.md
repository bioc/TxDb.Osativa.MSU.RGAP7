# TxDb.Osativa.MSU.RGAP7

**TxDb.Osativa.MSU.RGAP7** is a Bioconductor transcript annotation package
for *Oryza sativa* (rice), generated from the Rice Genome Annotation Project
(RGAP) Release 7 / MSU7 GFF3 annotation using the IRGSP-1.0 reference genome.
It provides gene, transcript, exon, and coding sequence (CDS) annotations
keyed by MSU locus identifiers. The resource is available through Bioconductor's
AnnotationHub.

## Installation

Install the package from Bioconductor:

```r
if (!requireNamespace("BiocManager", quietly = TRUE)) {
    install.packages("BiocManager")
}
BiocManager::install("TxDb.Osativa.MSU.RGAP7")
```

To install the development version from GitHub:

```r
if (!requireNamespace("remotes", quietly = TRUE)) {
    install.packages("remotes")
}
remotes::install_github("kabilanbio/TxDb.Osativa.MSU.RGAP7")
```

## Usage

Retrieve the TxDb resource from AnnotationHub:

```r
library(AnnotationHub)
library(GenomicFeatures)

ah <- AnnotationHub()
query(ah, "TxDb.Osativa.MSU.RGAP7")

# AnnotationHub identifier for this resource
txdb <- ah[["AH122276"]]

seqinfo(txdb)
genes(txdb)
head(transcripts(txdb))
exonsBy(txdb, by = "tx")
cdsBy(txdb, by = "tx")
```

## Converting MSU identifiers to RAP-DB identifiers

Load the package to use its `msu_to_rap()` helper:

```r
library(TxDb.Osativa.MSU.RGAP7)
```

Gene models are keyed by MSU locus identifiers (`LOC_Os##g#####`). The
`msu_to_rap()` function translates these to RAP-DB identifiers
(`Os##g#######`). Input order is preserved, and identifiers that cannot be
converted are omitted. This function requires the `riceidconverter` package:

```r
msu_to_rap(c("LOC_Os01g01010", "LOC_Os01g01019", "LOC_Os01g01040"))
#> [1] "Os01g0100100" "Os01g0100200" "Os01g0100500"

# Optionally restrict results to identifiers present in another object
msu_to_rap(msu_ids, universe = rownames(obj[["RNA"]]))
```

## Data source and reproducibility

The annotation is based on the IRGSP-1.0 assembly and RGAP Release 7 / MSU7.
The GFF3 annotation and matching reference FASTA source locations are recorded
in `inst/scripts/make-data.R`. The FASTA is used to provide sequence lengths
and linear sequence representation when constructing the TxDb.

Source URLs:
- GFF3: `https://rice.uga.edu/pub/data/Eukaryotic_Projects/o_sativa/annotation_dbs/pseudomolecules/version_7.0/all.dir/all.gff3`
- FASTA: `https://rice.uga.edu/osa1r7_download/osa1_r7.asm.fa.gz`

## Documentation

See the package vignette:

```r
vignette("TxDb.Osativa.MSU.RGAP7", package = "TxDb.Osativa.MSU.RGAP7")
```
