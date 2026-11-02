# TxDb.Osativa.MSU.RGAP7

**TxDb.Osativa.MSU.RGAP7** is a Bioconductor transcript annotation package
for *Oryza sativa* (rice), generated from the Rice Genome Annotation Project
(RGAP) Release 7 / MSU7 GFF3 annotation using the IRGSP-1.0 reference genome.
It provides gene, transcript, exon, and coding sequence (CDS) annotations
keyed by MSU locus identifiers.

## Installation

This package is available in the Bioconductor development repository
(Bioconductor 3.24) and requires R 4.6.0 or later.

```r
if (!requireNamespace("BiocManager", quietly = TRUE)) {
    install.packages("BiocManager")
}

BiocManager::install(version = "devel")
BiocManager::install(c(
    "TxDb.Osativa.MSU.RGAP7",
    "AnnotationHub",
    "GenomicFeatures",
    "GenomicRanges"
))
```

See the [Bioconductor installation instructions](https://bioconductor.org/install/)
for information about the R version required for the development branch.

## Retrieve the TxDb from AnnotationHub

The TxDb SQLite resource is hosted on AnnotationHub and downloaded when
requested. Retrieve the registered rice resource directly:

```r
library(AnnotationHub)
library(GenomicFeatures)

ah <- AnnotationHub()
txdb <- ah[["AH122276"]]
```

The resource describes the IRGSP-1.0 assembly and includes the 12 nuclear
chromosomes, unanchored sequences (`ChrUn`), and the Syngenta pseudomolecule
(`ChrSy`). You can search AnnotationHub for the package name to inspect
available resources:

```r
query(ah, "TxDb.Osativa.MSU.RGAP7")
```

## Query the annotation

```r
genes(txdb)
head(transcripts(txdb))
exonsBy(txdb, by = "tx")
cdsBy(txdb, by = "tx")
```

## Converting MSU identifiers to RAP-DB identifiers

Gene models are keyed by MSU locus identifiers (`LOC_Os##g#####`). The
`msu_to_rap()` function translates these to RAP-DB identifiers
(`Os##g#######`). Input order is preserved, and identifiers that cannot be
converted are omitted. This function requires the `riceidconverter` package.

```r
msu_to_rap(c("LOC_Os01g01010", "LOC_Os01g01019", "LOC_Os01g01040"))
#> [1] "Os01g0100100" "Os01g0100200" "Os01g0100500"

# Optionally restrict results to identifiers present in another object
msu_to_rap(msu_ids, universe = rownames(obj[["RNA"]]))
```

## Vignette

For a complete walkthrough, see the package vignette:

```r
browseVignettes("TxDb.Osativa.MSU.RGAP7")
```
