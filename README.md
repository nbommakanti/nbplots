# NB Plots

A collection of miscellaneous helper functions for my plots.


## Generating a 24-2 plot

Likely the most useful code in this package is the function which makes it easier to create this:

![alt text](images/example.png)


### Background
This is currently a two step process:

1. Left join to VF map and create facet plot facetted by VF location
2. Convert to a grob object then remove the empty locations

It would be more convenient for this to be a one-step process so a user could simply call `vf_plot` similar to `ggplot`,  however converting back from a grob to a ggplot with ggplotify::as.ggplot does not allow for appropriate manipulation of the labels, scale, etc. as with a true ggplot.

For this reason we will remain with the two-step process for now

### Operation

```{r}
# Load package
library(nbplots)

# Load data
to_plot <- grn[ideye == "chosen_eye", .(ideye, x, y, totaldev, time)]

# Add vf locations
to_plot <- add_vf_locations(to_plot)

# Plot, making sure to facet_wrap by location and with 8 rows
p <- ggplot(to_plot, aes(time, totaldev))
p <- p + geom_point()
p <- p + facet_wrap(. ~ location, nrow = 8)

# Remove empty locations  
g <- vf_plot(p)
```

Now to output this plot you can either:

```{r}
# Save plot
ggsave(filename = "my_plot.png",
       plot = g,
       path = "path/to/file")
       
# Or you can display the plot
library(grid)
grid.newpage()
grid.draw(g)
```

As noted above, if you want to adjust any aspects of the plot, do this before the second step, e.g. 

```{r}
# Plot, making sure to facet_wrap by location and with 8 rows
p <- ggplot(to_plot, aes(time, totaldev))
p <- p + geom_point(color = "darkblue")
p <- p + labs(title = "My outstanding 24-2 plot")
p <- p + facet_wrap(. ~ location, nrow = 8)
```
