# NEWS for TxDb.Osativa.MSU.RGAP7 Package

## Version 0.99.0 (2026-08-04)

### Initial Release

- First release of the package.
- The TxDb resource is distributed through AnnotationHub rather than shipped
  inside the package; it is retrieved at runtime with `AnnotationHub()`.
- Added `msu_to_rap()` to convert MSU/RGAP7 gene identifiers to RAP-DB
  identifiers via the `riceidconverter` package.
- Added `inst/scripts/make-data.R` and `inst/scripts/make-metadata.R`
  documenting how the TxDb resource and its AnnotationHub metadata are built.
- Added unit tests for `msu_to_rap()`.

## Version 0.99.1 (2026-08-07)

### Author update

- Updated the author details in `DESCRIPTION`.

## Version 0.99.2 (2026-08-07)

- Updated `README.md` file.

## Version 0.99.3 (2026-08-07)

- Updated `man` file.

## Version 0.99.4 (2026-08-07)

- Updated `metadata.csv` file.

## Version 0.99.5 (2026-08-07)

- Updated `DESCRIPTION` file.

## Version 0.99.6 (2026-08-08)

- Fixed the bugs.

## Version 0.99.7 (2026-08-08)

- Fixed the bugs.

## Version 0.99.8 (2026-08-15)

- Updated the `inst/scripts/make-data.R`

## Version 0.99.9 (2026-09-04)

- Fixed the WARNINGS.

## Version 0.99.10 (2026-11-02)

- Fixed the bugs.
