workout1-jeremy-martinez
================
Jeremy Martinez
10/18/2019

    ## Loading required package: readr

This report is about the different types of storms that were observed
between 2010-2015. To start we will be looking at the number of each
storm that occurred in each year

``` r
require("dplyr")
```

    ## Loading required package: dplyr

    ## 
    ## Attaching package: 'dplyr'

    ## The following objects are masked from 'package:stats':
    ## 
    ##     filter, lag

    ## The following objects are masked from 'package:base':
    ## 
    ##     intersect, setdiff, setequal, union

``` r
count(group_by(ibtracs,season))
```

    ## # A tibble: 6 x 2
    ## # Groups:   season [6]
    ##   season     n
    ##    <int> <int>
    ## 1   2010  2787
    ## 2   2011  3255
    ## 3   2012  3307
    ## 4   2013  3299
    ## 5   2014  3537
    ## 6   2015  3810

This shows us that number of storms are monotonically increasing
throughout the years between 2010-2015.To have a better understanding of
what is going on, we have to look at each hemisphere to get a sense of
how many storms were occurring during this time frame. To further
emphasize this fact, I have provided a map of storms that show the
number of storms increasing over the years below.

``` r
require("ggplot2")
```

    ## Loading required package: ggplot2

``` r
library("ggplot2")
ibtracs2=na.omit(ibtracs)
mapWorld= borders("world", colour="purple", fill="green")
ggplot(data = ibtracs2, aes(longitude,latitude,col=season))+mapWorld+geom_point()+ggtitle("Map of all storms")+xlab("Longitude")+ylab('Latitude')+
geom_hline(yintercept = 0, col='red', linetype=2)+
theme(plot.background = element_rect(fill='gray', colour='black'), panel.background = element_rect(fill = "lightblue",
colour = "lightblue",size = 0.5, linetype = "solid"))
```

![](workout1-jeremy-martinez_files/figure-gfm/unnamed-chunk-3-1.png)<!-- -->

From this we can see that the amount of storms in the northern
hemisphere are alot more that than the storms that occur in the southern
hemisphere. But the question is, do the total number of storms, occur
uniformly each year or is there more storm activity during certain
months. In the histogram provided below we can see that all of the
storms grouped together by month shows that most of the storms tend to
happen within the month of September. This shows that more activity
tends to happen in certain months then compared to being uniformly
throughout the years.

``` r
# Add month column
library(lubridate)
```

    ## 
    ## Attaching package: 'lubridate'

    ## The following object is masked from 'package:base':
    ## 
    ##     date

``` r
ibtrac_months <- mutate(ibtracs, month = month(iso_time, label = TRUE))
unique_months <- summarise(group_by(ibtrac_months, month), num_storms = n_distinct(serial_num))
ggplot(unique_months, aes(month, num_storms, col=month, fill=month)) + geom_histogram(stat = "identity")
```

    ## Warning: Ignoring unknown parameters: binwidth, bins, pad

![](workout1-jeremy-martinez_files/figure-gfm/unnamed-chunk-4-1.png)<!-- -->

In particular, if we were to look at two different basin within the
northen hemisphere, such as the northern atlantic, and eastern pacific
we can see that alot of storms over this six year period is much more
concentrated with in the eastern pacific. This is indicated by the
desnity plots where most of the stroms in the eastern pacific happen in
the beginning and tends to decrease over time, and for the northern
atlantic the storms increase very slowly indicating that storms happen
less often in this specific region during this time frame
.

``` r
ibtracs_basin=filter(select(ibtracs,name,season,basin), basin=="EP" | basin=="NA")
ggplot(data = ibtracs_basin, aes(x=basin,col=basin, fill= basin))+geom_density()+facet_grid(.~season)
```

![](workout1-jeremy-martinez_files/figure-gfm/unnamed-chunk-5-1.png)<!-- -->

In the images provided below, we can see the different nature of storms,
as well as there wind speeds and pressure. In the first image we can see
all the storms over several months between 2010-2015. In the following
graph, this graph looks at the different storms over a 6 year period and
how the patterns of these storms have evolved. In the final graph we can
see the how the storms have changed over the course of 12 months over a
6 year
period.

<img src="/Users/jeremymartinez/Desktop/Stat133/workouts/workout1/images/map-all-storms.png" style="display: block; margin: auto;" />

<img src="/Users/jeremymartinez/Desktop/Stat133/workouts/workout1/images/map-ep-na-storms-by-year.png" style="display: block; margin: auto;" />

<img src="/Users/jeremymartinez/Desktop/Stat133/workouts/workout1/images/map-ep-na-storms-by-month.png" style="display: block; margin: auto;" />
