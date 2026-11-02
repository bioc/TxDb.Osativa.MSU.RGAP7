### =========================================================================
### make-metadata.R
### -------------------------------------------------------------------------
###
### Generates inst/extdata/metadata.csv, the AnnotationHub resource
### description for the TxDb built by inst/scripts/make-data.R.
###
### The primary annotation source is the RGAP Release 7 / MSU7 GFF3 file.
### The IRGSP-1.0 FASTA is used by make-data.R to define sequence lengths.
###
### Validate the result with:
###     AnnotationHubData::makeAnnotationHubMetadata("<path to package>")
###
### =========================================================================

meta <- data.frame(
    Title = "TxDb.Osativa.MSU.RGAP7 RGAP Release 7",
    Description = paste(
        "Transcript annotation database for Oryza sativa (rice),",
        "generated from the Rice Genome Annotation Project (RGAP)",
        "Release 7 / MSU7 GFF3 annotation using the IRGSP-1.0",
        "reference genome."
    ),
    BiocVersion = "3.24",
    Genome = "IRGSP-1.0",
    SourceType = "GFF",
    SourceVersion = "7",
    SourceUrl = paste0(
        "https://rice.uga.edu/pub/data/Eukaryotic_Projects/",
        "o_sativa/annotation_dbs/pseudomolecules/version_7.0/",
        "all.dir/all.gff3"
    ),
    Species = "Oryza sativa",
    TaxonomyId = 4530L,
    Coordinate_1_based = TRUE,
    DataProvider = "Rice Genome Annotation Project (RGAP)",
    Maintainer = "Kabilan S <kabilan151414@gmail.com>",
    RDataClass = "TxDb",
    DispatchClass = "SQLiteFile",
    Location_Prefix = "https://zenodo.org/",
    RDataPath = paste0(
        "records/21783295/files/",
        "TxDb.Osativa.MSU.RGAP7.sqlite"
    ),
    ## Tags are colon separated; see
    ## ?AnnotationHubData::makeAnnotationHubMetadata
    Tags = paste(
        "AnnotationData",
        "TxDb",
        "Oryza sativa",
        "SequenceAnnotation",
        "AnnotationHub",
        sep = ":"
    ),
    stringsAsFactors = FALSE
)

write.csv(
    meta,
    file = "inst/extdata/metadata.csv",
    row.names = FALSE
)
