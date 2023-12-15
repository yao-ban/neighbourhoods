# Supplementary material for the paper ``Analysis of amino acid neighbourhoods in protein structures"

To generate plots of weight vs degree for each amino acid, run:

```
Rscript weights.R
```

This will generate one pdf file for each amino acid.

To generate plots of link weight distributions for each amino acid, run:

```
Rscript neighbourhoods.R
```

This will generate one pdf file, with $3 \times 16$ panels (3 secondary structure types and degrees 5--20), for each amino acid.

To generate plots of weight averages vs total degree for each amino acid, run:

```Rscript weights4.R```

This will generate one pdf file, with $3 \times 6$ panels (3 secondary structure types and 6 link types), for each amino acid.

To generate plots of neighbourhood weight profiles and link type correlations, run:

```Rscript wholenh.R d t```

where `d` is the total degree and `t` is the amino acid (1--20). This will generate one pdf file of neighbourhood weight profiles and one pdf file of link type correlations for each secondary structure type.
