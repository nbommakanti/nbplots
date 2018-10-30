# NB Plots

This is a collection of miscellaneous helper functions for my plots.

The code in this repository was used to create the plots for my 2018 AAO presentation.

Navigate to the `R` folder to see the code.

## Generating a 24-2 plot

Likely the most useful code in this package are the functions which make it easier to create this:

![alt text](images/example.png)


Currently this will only generate a 24-2 plot for the right eye. Feel free to modify the `vf_plot()` function to allow for the generation of left-eye plots. Note that determining which specific grobs to remove is not straightforward - I did so largely through trial and error. 

### Background
I considered a few approaches to creating a 24-2 plot. The approach I use here may not be the best, but it works well enough. Feel free to let me know if you have any suggestions!

### Approach
The general approach is:

1. Arrange the plots in an 8x9 grid.
2. Remove the empty plots.

We will accomplish step 1 by joining our data:

| x   | y  | totaldev | time |
|-----|----|----------|------|
| -27 | -3 | -30      | 0    |
| -27 | 3  | -28      | 0    |
| -21 | -9 | -21      | 0    |
...
| 21 | -3 | -2       | 7.091283 |
| 21 | 3  | -3       | 7.091283 |
| 21 | 9  | 2        | 7.091283 |

to a location map (which I have included in the `data` folder)

| x | y | location |
| - | - | - |
| -27 | 21 | 1 |
| -21 | 21 | 2 |
...
| 21 | -21 | 72 |


The result will look like this:

| x   | y  | totaldev | time      | location |
|-----|----|----------|-----------|----------|
|     |    |          |           |          |
| -27 | 21 | NA       | NA        | 1        |
| -21 | 21 | NA       | NA        | 2        |
| -15 | 21 | NA       | NA        | 3        |
| -9  | 21 | -5       | 0         | 4        |
| -9  | 21 | -9       | 0.9855868 | 4        |
| -9  | 21 | -30      | 1.921757  | 4        |
| -9  | 21 | -17      | 2.4406314 | 4        |
| -9  | 21 | -27      | 4.2086479 | 4        |
| -9  | 21 | -25      | 5.3617021 | 4        |
| -9  | 21 | -29      | 6.4378861 | 4        |
| -9  | 21 | -29      | 6.6108442 | 4        |
| -9  | 21 | -29      | 7.0912835 | 4        |
| -3  | 21 | -3       | 0         | 5        |
...
| x  | y   | totaldev | time      | location |
|----|-----|----------|-----------|----------|
| 3  | -21 | -1       | 7.0912835 | 69       |
| 9  | -21 | -4       | 0         | 70       |
| 9  | -21 | 0        | 0.9855868 | 70       |
| 9  | -21 | -5       | 1.921757  | 70       |
| 9  | -21 | -1       | 2.4406314 | 70       |
| 9  | -21 | -1       | 4.2086479 | 70       |
| 9  | -21 | -5       | 5.3617021 | 70       |
| 9  | -21 | -3       | 6.4378861 | 70       |
| 9  | -21 | -6       | 6.6108442 | 70       |
| 9  | -21 | -7       | 7.0912835 | 70       |
| 15 | -21 | NA       | NA        | 71       |
| 21 | -21 | NA       | NA        | 72       |


The missing values are expected. Remember that we do not expect there to be values at (21, -21), the bottom right corner.

We can then do step 2.

Both of these steps (1. Left join to VF map and create a plot facetted by VF location and 2. Convert to a grob object then remove the empty locations) can be done easily by using the `add_vf_locations()` and `vf_plot()` functions.

*Note that it would be more convenient for this to be a one-step process, e.g. where the user could simply call `vf_plot` in a similar manner to `ggplot`.*

*The problem with this approach is that converting back from a grob to a ggplot is not trivial, even with helper functions such as `ggplotify::as.ggplot` (in my testing this does not allow for appropriate manipulation of the labels, scale, etc. as with a true ggplot). If you have suggestions for improvement, please feel free to let me know.*

### Operation

```{r}
# Load package
library(nbplots)

# Load, generate, or subset data
to_plot <- "your_data_here"

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
p <- p + geom_smooth(method = "lm", color = "darkred")
p <- p + labs(title = "My outstanding 24-2 plot")
p <- p + facet_wrap(. ~ location, nrow = 8)
```
