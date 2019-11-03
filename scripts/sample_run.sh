## Sample run for frequent subgraph mining
## Required data files: mutation.rds ppi.rds expression.rds (optional)

## Generate RWR profiles integrating gene expression
Rscript scripts/NetworkProfilesWeighted.R -m mutation.rds -e expression.rds -n ppi.rds -t 20 -o sample_out

## Generate per sample graph files from RWR profiles (support is to prefilter before FSM run)
Rscript scripts/GenerateGraphs.R -r sample_out_NetworkProfiles.rds -n ppi.rds -t 20 -o sample_out_graphs -s 20

## Generate FSGs (timeout for early stopping if sampling is not done)
timeout 60 ~/regrax sample -o fsm_results/TCGA-OR-A5J1-01_graph -c results/temp_cache --support 20 --samples 1000 --non-unique digraph --min-vertices=6 --no-caching --max-edges=100 --overlap-pruning --extension-pruning --extend-from-embeddings sample_out_graphs/TCGA-OR-A5J1-01_graph.tsv graple

## For 'regrax' installation
https://github.com/timtadh/regrax.git
