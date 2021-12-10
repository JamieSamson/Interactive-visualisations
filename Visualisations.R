######################################################################################################
###Interactive visualisations
######################################################################################################

###################
##Network diagram
###################

#Load packages
library(networkD3)

#Create link file of frequency of interactions
source<-c(0,0,0,0,0,1,1,1,1,2,2,2,3,3,4)
target<-c(0,1,2,3,4,1,2,3,4,2,3,4,3,4,4)
value<-c(14,41,74,21,7,29,200,20,10,59,85,35,19,30,24)
links<-data.frame(source,target,value)

#Create a node file
name<-c("Option 1","Option 2","Option 3","Option 4","Option 5")
size<-c(171,329,512,194,130)
nodes<-data.frame(name,size)

#Prep a unique colour function for each of the nodes
nameCol<-paste0(nodes$name,collapse='","') 
my_color <- paste0('d3.scaleOrdinal() .domain(["',nameCol,'"])','.range(["#008A80","#BF1238","#CF7600","#1D97C3","#EBB914"])')

#A force network diagram using the link and node data
fn<-forceNetwork(Links=links,Nodes=nodes,Source="source",
                Target="target",Value="value",NodeID="name",
                Group ="name",Nodesize = "size",
                
                #Customisable features
                colourScale=my_color,
                fontSize = 20,
                fontFamily="DM Sans",
                opacity = 0.7,
                legend=T,
                bounded=T,
                linkDistance = JS('function(){d3.select("body").style("background-color", "white");return 400;}'))
fn

#Save a file, changing out the file path/file name. This will create a single html file
saveNetwork(fn, "network.html", selfcontained = F)



###################
##Tree map
###################

#Load packages
library(plotly)
library(htmltools)

#Read in example data
treemapDf<-read.csv("Data files/Treemap.csv",fileEncoding = 'UTF-8-BOM')
head(treemapDf)

tm <- plot_ly(
  type='treemap', #Type of plotly plot
  values=c(treemapDf$size,rep(0,5)), #Bring in values and create blanks for groupings
  labels=c(treemapDf$value,unique(treemapDf$group)), #Group labels
  parents=c(treemapDf$group,rep("",5)), #Similarly with values, add blank enteries at the end for grouping
  textinfo="label+percent", #Donates the type of label
  hoverinfo="text", #And hover info
  text=~paste0(c(treemapDf$value,unique(treemapDf$group))," ",c(treemapDf$tidiedPercentage,rep("",5))), #Need and tidy hover labels
  domain=list(column=0),
  marker=list(colors=c(rep("#76dcb9",5),
                       rep("#f9aa68",5),
                       rep("#848bd3",7),
                       rep("#f372a2",7),
                       rep("#EBB914",4),
                       "#76dcb9","#f9aa68",
                       "#848bd3","#f372a2",
                       "#EBB914"))) #Marker list matrix for colouring in grouping and individual boxes
tm

#Save a file, changing out the file path/file name. This will create a single html file
save_html(tm, "treemap.html")
