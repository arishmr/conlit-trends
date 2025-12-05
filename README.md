# Publication trends in English literature
Analysis of publication trends in the CONLIT database of contemporary English literature.

### Dataset
The dataset used in this analysis is publicly available and can be downloaded at this link: [CONLIT dataset](https://figshare.com/articles/dataset/CONLIT/21166171/1)

This analysis involves only the metadata file ``CONLIT_META.csv``

Information on the variables contained within the file is available in ``CONLIT_README.pdf``

Reference: Piper, Andrew. "The CONLIT dataset of contemporary literature." _Journal of Open Humanities Data_ 8 (2022).

## Analysis pipeline

``00-packages.R`` loads relevant packages (and installs them if not already installed)

``01-loaddata.R`` loads the dataset from a local directory (``data``), cleans some variables, and converts variables to appropriate formats such as numeric, factor, and date

``02-dataviz.R`` produces visualisations of publication trends over time

``03-timeseries.R`` runs Mann-Kendall tests for monotonic trends in variables representing book length and compexity

``04-grangercausality.R`` runs Granger causality tests for associations between book length and complexity variables and Goodreads ratings
