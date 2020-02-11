# Load package
library(networkD3)
library(tidyverse)

# Load data
setwd("")  # fill in your work directory here
summary.table <- read.csv("summary table.csv", header = T, stringsAsFactors = F)

head(summary.table)

# create nodes
nodes <- data.frame(name = unique(c(summary.table$Source, colnames(summary.table))))

# create links
links <- summary.table %>% gather(names(summary.table)[-1], key = "target", value = "value")

links$IDsource <- match(links$Source, nodes$name) - 1 # these are indexes of sources
links$IDtarget <- match(links$target, nodes$name) - 1 # these are indexes of targets

p <- sankeyNetwork(Links = links, Nodes = nodes, Source = "IDsource",
                   Target = "IDtarget", Value = "value", NodeID = "name",
                   units = "TWh", fontSize = 12, nodeWidth = 30)
p
