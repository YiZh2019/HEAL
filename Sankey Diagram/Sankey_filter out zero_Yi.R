# Load package
library(networkD3)
library(tidyverse)

# Load data
setwd("/Users/zhan039/Desktop/USC HEAL/sankey/Yi")  # fill in your work directory here
summary.table <- read.csv("summary table.csv", header = T, stringsAsFactors = F)

head(summary.table)

# create links
links <- summary.table %>% gather(names(summary.table)[-1], key = "target", value = "value") %>% filter(value > 0)

# create nodes
nodes <- data.frame(name = unique(c(links$target, links$Source)))

links$IDsource <- match(links$Source, nodes$name) - 1 # these are indexes of sources
links$IDtarget <- match(links$target, nodes$name) - 1 # these are indexes of targets

p <- sankeyNetwork(Links = links, Nodes = nodes, Source = "IDsource",
                   Target = "IDtarget", Value = "value", NodeID = "name", fontSize = 12, nodeWidth = 30)
p
saveNetwork(p, "sankey_no_zero.html")
