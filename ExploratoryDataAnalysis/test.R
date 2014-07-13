## Tonga Trench Earthquakes
data(quakes)
Depth <- equal.count(quakes$depth, number=8, overlap=.1)
xyplot(lat ~ long | Depth, data = quakes)

## Examples with data from `Visualizing Data' (Cleveland)
## (obtained from Bill Cleveland's Homepage :
## http://cm.bell-labs.com/cm/ms/departments/sia/wsc/, also
## available at statlib)
data(ethanol)
EE <- equal.count(ethanol$E, number=9, overlap=1/4)
## Constructing panel functions on the fly; prepanel
xyplot(NOx ~ C | EE, data = ethanol,
       prepanel = function(x, y) prepanel.loess(x, y, span = 1),
       xlab = "Compression Ratio", ylab = "NOx (micrograms/J)",
       panel = function(x, y) {
         panel.grid(h=-1, v= 2)
         panel.xyplot(x, y)
         panel.loess(x,y, span=1)
       },
       aspect = "xy")

## banking to 45 degrees

data(sunspots)
xyplot(sunspot ~ 1:37 ,type = "l", aspect="xy",
       scales = list(y = list(log = TRUE)),
       sub = "log scales")

## Multiple variables in formula for grouped displays

data(iris)
xyplot(Sepal.Length + Sepal.Width ~ Petal.Length + Petal.Width | Species, 
       data = iris, 
       allow.multiple = FALSE, 
       scales = "free",
       layout = c(2, 2),
       auto.key = list(x = .6, y = .7, corner = c(0, 0)))

data(state)
## user defined panel functions
states <- data.frame(state.x77,
                     state.name = dimnames(state.x77)[[1]], 
                     state.region = state.region) 
xyplot(Murder ~ Population | state.region, data = states, 
       groups = as.character(state.name), 
       panel = function(x, y, subscripts, groups)  
         ltext(x=x, y=y, label=groups[subscripts], cex=.7, font=3))

data(barley)
barchart(yield ~ variety | site, data = barley,
         groups = year, layout = c(1,6),
         ylab = "Barley Yield (bushels/acre)",
         scales = list(x = list(abbreviate = TRUE,
                                minlength = 5)))
barchart(yield ~ variety | site, data = barley,
         groups = year, layout = c(1,6), stack = TRUE, 
         auto.key = list(points = FALSE, rectangles = TRUE, space = "right"),
         ylab = "Barley Yield (bushels/acre)",
         scales = list(x = list(rot = 45)))

data(singer)
bwplot(voice.part ~ height, data=singer, xlab="Height (inches)")
dotplot(variety ~ yield | year * site, data=barley)

dotplot(variety ~ yield | site, data = barley, groups = year,
        key = simpleKey(levels(barley$year), space = "right"),
        xlab = "Barley Yield (bushels/acre) ",
        aspect=0.5, layout = c(1,6), ylab=NULL)

stripplot(voice.part ~ jitter(height), data = singer, aspect = 1,
          jitter = TRUE, xlab = "Height (inches)")
## Interaction Plot
data(OrchardSprays)
bwplot(decrease ~ treatment, OrchardSprays, groups = rowpos,
       panel = "panel.superpose",
       panel.groups = "panel.linejoin",
       xlab = "treatment",
       key = list(lines = Rows(trellis.par.get("superpose.line"),
                               c(1:7, 1)), 
                  text = list(lab = as.character(unique(OrchardSprays$rowpos))),
                  columns = 4, title = "Row position"))
