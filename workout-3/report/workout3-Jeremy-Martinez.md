workout3
================
Jeremy Martinez
12/1/2019

## Run all codes in clean-data-script.R 1st before moving on in order to get data frames

``` r
# creates a working directory and reads each csv as a dataframe
setwd("~/Desktop/Stat133/workouts/workout3/data/")
AB=read.csv("../data/cleandata/Abhijit_Banerjee.csv")[-1]
ED=read.csv("../data/cleandata/Esther_Duflo.csv")[-1]
```

## 3 Practice with Regular Expressions

\#A

``` r
library(stringr)

# Gets the sum of each scholars article that begins with a vowel, which includes lowercase and uppercase

#Abhojit Banerjee
sum(str_count(substring(AB$paperName,1,1), "[aeiouAEIOU]"))
```

    ## [1] 118

``` r
#Esther Duflo
sum(str_count(substring(ED$paperName,1,1), "[aeiouAEIOU]"))
```

    ## [1] 131

\#B

``` r
# Finds the articles that ends with "s" and calculates the total number of articles that each author has that ends with "s" respectively.

#Abhojit Banerjee
length(AB$paperName[str_sub(AB$paperName,-1) == 's'])
```

    ## [1] 78

``` r
#Esther Duflo
length(ED$paperName[str_sub(ED$paperName,-1) == 's'])
```

    ## [1] 93

\#C

``` r
#Finds the max length of the paperName column of both scholars

#Abhojit Banerjee
AB$paperName[str_length(AB$paperName) == max(str_length(AB$paperName))]
```

    ## [1] Voters be Primed to Choose Better Legislators? Experimental Evidence from Rural India,” October 2010. mimeo, Harvard Universiy. 4, 27, 29, Selvan Kumar, Rohini Pande, and Felix …
    ## 475 Levels: ¿ Cuál es tu evidencia? ...

``` r
#Esther Duflo
ED$paperName[str_length(ED$paperName) == max(str_length(ED$paperName))]
```

    ## [1] controlling costs of hivaids managementunique management software to empower organisations to formulate implement strategies best suited for their specific requirements
    ## 438 Levels:  bibliography ... 開発経済学 development economics いまも 飢餓 に苦しむ多くの人たちを救うことはできるのでしょうか新しい経済学 へようこそnew economics 新しい経済学

\#D

``` r
# creates a histagram of both scholars usage of punctuations within the title 

# Abhojit Banerjee

summary(str_count(AB$paperName, '[:punct:]'))
```

    ##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
    ##   0.000   0.000   1.000   1.642   2.000  21.000

``` r
hist(str_count(AB$paperName, '[:punct:]'), xlab = "punctuation")
```

![](workout3-Jeremy-Martinez_files/figure-gfm/unnamed-chunk-5-1.png)<!-- -->

``` r
# Esther Duflo
summary(str_count(ED$paperName, '[:punct:]'))
```

    ##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
    ##       0       0       0       0       0       0

``` r
hist(str_count(ED$paperName, '[:punct:]'), xlab = "punctuation")
```

![](workout3-Jeremy-Martinez_files/figure-gfm/unnamed-chunk-5-2.png)<!-- -->

\#E

``` r
# Gets rid of certain words, punctuations and digits from article title in the paperName column for each scholar's dataframe

# Abhojit Banerjee
AB$paperName <- gsub('the |a |an |and |in |if |but ', " ",tolower(AB$paperName)) 
AB$paperName <- gsub("[[:punct:]]", "", AB$paperName)
AB$paperName <- gsub('[[:digit:]]', "", AB$paperName)

# Esther Duflo
ED$paperName <- gsub('the |a |an |and |in |if |but ', "",tolower(ED$paperName)) 
ED$paperName <- gsub("[[:punct:]]", "", ED$paperName)
ED$paperName <- gsub('[[:digit:]]', "", ED$paperName)
```

\#F

``` r
library(jiebaR)
```

    ## Loading required package: jiebaRD

``` r
# Gets the top 10 words with in the paperName column for Abhojit Banerjee
sort(table(qseg[AB$paperName]), decreasing = TRUE)[1:10]
```

    ## Warning in `[.qseg`(qseg, AB$paperName): Quick mode is depreciated, and is
    ## scheduled to be remove in v0.11.0. If you want to keep this feature, please
    ## submit a issue on GitHub page to let me know.

    ## 
    ##          of        from    evidence          to       india development 
    ##         175          68          67          67          46          42 
    ##         for   economics          dp    economic 
    ##          41          38          30          30

\#G

``` r
# Gets the top 10 words with in the paperName column for Ester Duflo
sort(table(qseg[ED$paperName]), decreasing = TRUE)[1:10]
```

    ## 
    ##          of        from    evidence          to         for  randomized 
    ##         179         103          91          79          53          52 
    ##   economics development       india          on 
    ##          49          48          44          37

# 4 Data visualizations

# In the word cloud, we can see that the most commonly used words appear in the center which signifies that these words are the most commonly found words with in the titles follow by words that surround the center words, which represent the least commonly used words within article.

``` r
#A 
library(wordcloud,tm)
```

    ## Loading required package: RColorBrewer

``` r
#Abhojit Banerjee wordcloud

# Creates a wordcloud of the frequently used words within the paperName and saves it as a png image

png(file="../images/Abhojit_Banerjee.png")
wordcloud(AB$paperName,colors = brewer.pal(8,"Dark2"),random.order = FALSE)
```

    ## Loading required namespace: tm

    ## Warning in tm_map.SimpleCorpus(corpus, tm::removePunctuation):
    ## transformation drops documents

    ## Warning in tm_map.SimpleCorpus(corpus, function(x) tm::removeWords(x,
    ## tm::stopwords())): transformation drops documents

``` r
dev.off()
```

    ## quartz_off_screen 
    ##                 2

``` r
# Esther Duflo wordcloud

# Creates a wordcloud of the frequently used words within the paperName and saves it as a png image
png(file="../images/Esther_Duflo.png")
wordcloud(ED$paperName,colors = brewer.pal(8,"Dark2"),random.order = FALSE)
```

    ## Warning in tm_map.SimpleCorpus(corpus, tm::removePunctuation):
    ## transformation drops documents

    ## Warning in tm_map.SimpleCorpus(corpus, function(x) tm::removeWords(x,
    ## tm::stopwords())): transformation drops documents

``` r
dev.off()
```

    ## quartz_off_screen 
    ##                 2

``` r
#B
library(ggplot2)
library(dplyr)
```

    ## 
    ## Attaching package: 'dplyr'

    ## The following objects are masked from 'package:stats':
    ## 
    ##     filter, lag

    ## The following objects are masked from 'package:base':
    ## 
    ##     intersect, setdiff, setequal, union

``` r
# Creates a plot of the number of publications and saves it as a png image
png(file="../images/Abhojit_Banerjee_publications.png")
ggplot(data = data.frame(table(AB$year[AB$year!=""])))+geom_line(aes(x=Var1,y=Freq,group=1))+scale_x_discrete(breaks = seq(,2019,4))+ggtitle("Number of Publications of Abhojit Banerjee")+xlab("Year")+ylab("Publications")
dev.off()
```

    ## quartz_off_screen 
    ##                 2

``` r
# Creates a plot of the number of publications and saves it as a png image
png(file="../images/Esther_Duflo_publications.png")
ggplot(data = data.frame(table(ED$year[ED$year!=""])))+geom_line(aes(x=Var1,y=Freq,group=1))+scale_x_discrete(breaks = seq(,2019,4))+ggtitle("Number of Publications of Esther Duflo")+xlab("Year")+ylab("Publications")
dev.off()
```

    ## quartz_off_screen 
    ##                 2

``` r
#C
# Sorts throughout the paperName column and selects the top 10 most used words,and then choosing 3 of the top 10 words for each scholar
words_AB=sort(table(qseg[AB$paperName]), decreasing = TRUE)[1:10]
words_AB
```

    ## 
    ##          of        from    evidence          to       india development 
    ##         175          68          67          67          46          42 
    ##         for   economics          dp    economic 
    ##          41          38          30          30

``` r
top_3_AB=c('of',"from","evidence")

words_ED=sort(table(qseg[ED$paperName]), decreasing = TRUE)[1:10]
words_ED
```

    ## 
    ##          of        from    evidence          to         for  randomized 
    ##         179         103          91          79          53          52 
    ##   economics development       india          on 
    ##          49          48          44          37

``` r
top_3_ED=c("to","for","india")
```

``` r
# Creating a data frame of 3 words within the top 10 words that are used, then making all data frames the same length in order to plot their usage later on.
AB_freq1 = data.frame(table(filter(select(AB,year),str_detect(AB$paperName, 'of'))))
AB_freq2 = data.frame(table(filter(select(AB,year),str_detect(AB$paperName, 'from'))))
AB_freq3 =data.frame(table(filter(select(AB,year),str_detect(AB$paperName, 'evidence'))))
colnames(AB_freq1) = c('year1','num1')
colnames(AB_freq2) = c('year2','num2')
colnames(AB_freq3) = c('year3','num3')
AB_freq2[(nrow(AB_freq2 + 1)):nrow(AB_freq1),] = NA
```

    ## Warning in Ops.factor(left, right): '+' not meaningful for factors

``` r
AB_freq3[(nrow(AB_freq3 + 1)):nrow(AB_freq1),] = NA
```

    ## Warning in Ops.factor(left, right): '+' not meaningful for factors

``` r
# Creates a plot of the 3 words choosen from the top 10 and seeing how much they were used during a 22 year time span
png(file="../images/Abhojit_Banerjee_word_trend.png")
ggplot(cbind(AB_freq1,AB_freq2,AB_freq3)) + geom_line(aes(x = year1, y = num1, group = 1,color = 'of'))+
  geom_line(aes(x = year2, y = num2, group = 1, color = 'from'))+
  geom_line(aes(x = year3, y = num3, group = 1,color = 'evidence')) +
  scale_x_discrete(breaks = seq(, 2019 , 4))+
  xlab('year') + ylab('number')+ggtitle("Top 3 Words of Abhojit Banerjee")
```

    ## Warning: Removed 10 rows containing missing values (geom_path).

    ## Warning: Removed 11 rows containing missing values (geom_path).

``` r
dev.off()
```

    ## quartz_off_screen 
    ##                 2

``` r
# Creating a data frame of 3 words within the top 10 words that are used, then making all data frames the same length in order to plot their usage later on.
ED_freq1 = data.frame(table(filter(select(ED,year),str_detect(ED$paperName, 'to'))))
ED_freq2 = data.frame(table(filter(select(ED,year),str_detect(ED$paperName, 'for'))))

ED_freq3 =data.frame(table(filter(select(ED,year),str_detect(ED$paperName, 'india'))))
colnames(ED_freq1) = c('year1','num1')
colnames(ED_freq2) = c('year2','num2')
colnames(ED_freq3) = c('year3','num3')
ED_freq2[(nrow(ED_freq2 + 1)):nrow(ED_freq1),] = NA
```

    ## Warning in Ops.factor(left, right): '+' not meaningful for factors

``` r
ED_freq3[(nrow(ED_freq3 + 1)):nrow(ED_freq1),] = NA
```

    ## Warning in Ops.factor(left, right): '+' not meaningful for factors

``` r
# Creates a plot of the 3 words choosen from the top 10 and seeing how much they were used during a 22 year time span
png(file="../images/Ester_Duflo_word_trend.png")
ggplot(cbind(ED_freq1,ED_freq2,ED_freq3)) + geom_line(aes(x = year1, y = num1, group = 1,color = 'to'))+
  geom_line(aes(x = year2, y = num2, group = 1, color = 'for'))+
  geom_line(aes(x = year3, y = num3, group = 1,color = 'india')) +
  scale_x_discrete(breaks = seq(, 2019 , 4))+
  xlab('year') + ylab('number')+ggtitle("Top 3 Words of Ester Duflo")
```

    ## Warning: Removed 2 rows containing missing values (geom_path).

    ## Warning: Removed 4 rows containing missing values (geom_path).

``` r
dev.off()
```

    ## quartz_off_screen 
    ##                 2

# 5 Report

The purpose of this report is to see how much these scholars know each
other and as well as getting more information about them and the
articles that they’d published

We will first look at the average number off co author that each author
has.

``` r
#Q1
# Makes researcher column treated as character vectors for Banerjee
AB_authors <- as.character(AB$researcher)

# Finds the number of coauthors for all of Nanerjee's papers
num_AB_coauthor <- str_count(AB_authors, "[A-Z][ ][A-Z]") - 1

# Average number of coauthors for Banerjee
avg_num_ED_coauthor <- mean(num_AB_coauthor)
avg_num_ED_coauthor
```

    ## [1] 2.40202

``` r
# Makes  researcher column a character column for Duflo
ED_authors <- as.character(ED$researcher)

# Finds the number of coauthors for all of Duflo's papers
num_ED_coauthor <- str_count(ED_authors, "[A-Z][ ][A-Z]") - 1

# Average  number of coauthors Duflo had  
avg_num_duflo_coauthor <- mean(num_ED_coauthor)
avg_num_duflo_coauthor
```

    ## [1] 2.197556

Here we can see that Abhojit Banerjee has more co authurs on average
conpared to Ester Duflo.

Here we can see that both of these scholars are friends and are friends
with 3 other individuals within their academic field

``` r
#Q2
# This allows us to find the unique names of the researchers within the Abhojit Banerjee data frame that unique that
x=subset(AB$researcher,AB$researcher==unique(AB$researcher))
```

    ## Warning in `==.default`(AB$researcher, unique(AB$researcher)): longer
    ## object length is not a multiple of shorter object length

    ## Warning in is.na(e1) | is.na(e2): longer object length is not a multiple of
    ## shorter object length

``` r
x=data.frame(researcher=x)
x
```

    ##                                     researcher
    ## 1                                  AV Banerjee
    ## 2                       AV Banerjee, AF Newman
    ## 3             AV Banerjee, A Banerjee, E Duflo
    ## 4 A Banerjee, E Duflo, R Glennerster, C Kinnan
    ## 5                         AV Banerjee, E Duflo

``` r
# This allows us to find the unique names of the researchers within the Ester Duflo data frame that unique that
y=subset(ED$researcher,ED$researcher==unique(ED$researcher))
```

    ## Warning in `==.default`(ED$researcher, unique(ED$researcher)): longer
    ## object length is not a multiple of shorter object length
    
    ## Warning in `==.default`(ED$researcher, unique(ED$researcher)): longer
    ## object length is not a multiple of shorter object length

``` r
y=data.frame(researcher=y)
y
```

    ##                                     researcher
    ## 1          M BERTRAND, E DUFLO, S MULLAINATHAN
    ## 2             AV BANERJEE, A BANERJEE, E DUFLO
    ## 3                                      E DUFLO
    ## 4 A BANERJEE, E DUFLO, R GLENNERSTER, C KINNAN

``` r
# This allows us to find the the authors that both these authors have worked with 
mutual_friends=inner_join(x,y)
```

    ## Joining, by = "researcher"

    ## Warning: Column `researcher` joining factors with different levels,
    ## coercing to character vector

``` r
mutual_friends
```

    ## [1] researcher
    ## <0 rows> (or 0-length row.names)

In evaluating both data frames we see that both of these scholars have
both written 25 articles together.

``` r
#Q3
# By filtering through the data of both data frames, we able to locate only these two scholars to see if they published papers together
AB[["researcher"]] = toupper(AB[["researcher"]])
filter(select(AB,paperName,researcher), researcher== 'A BANERJEE, E DUFLO')
```

    ##                                                                                                                                           paperName
    ## 1                                                                                                                                addressing absence
    ## 2                                                                                                                      do firms want to borrow more
    ## 3                                                                           repensar l pobreza un giro radical en l luch contr l desigualdad global
    ## 4                                                                                                        more th  billion people are hungry   world
    ## 5                                                                                                                                repensar l pobreza
    ## 6                                                                                             nature of credit constraints evidence from  indi bank
    ## 7                                                                                                             improving health care delivery  india
    ## 8                                                                                                                              what do banks not do
    ## 9                                                                    n qi  on  road access to transportation infrastructure  economic growth  china
    ## 10                                                            poor economics  radical rethinking of  way to fight global poverty reprint edition ed
    ## 11                                                                                poor economics  radical thinking of  way to fight global poverty 
    ## 12                                                                                        inequality  growth what c  dat say nber working paper no 
    ## 13                                                 do firms want to borrow more testing credit constraints using  directed lending program banerjee
    ## 14                                                                                                                handbook of economic growth vol a
    ## 15                                                                                                      not so simple economics of lending to  poor
    ## 16                                                                                               education asymmetry bra v brawn  rural communities
    ## 17                                                                             dp under  thumb of history political institutions   scope for action
    ## 18                                                                                                                                  editors journal
    ## 19 開発経済学 development economics いまも 飢餓 に苦しむ多くの人たちを救うことはできるのでしょうか新しい経済学 へようこそnew economics 新しい経済学
    ## 20                                                                                                                 dp giving credit where it is due
    ## 21                                                                                               dp  experimental approach to development economics
    ## 22                                                                                      dp what is middle class about  middle classes around  world
    ## 23                                                                                                                      dp  economic lives of  poor
    ## 24                                                                                     economic lives of  poor development economics  public policy
    ## 25                                                       dp do firms want to borrow more testing credit constraints using  directed lending program
    ##             researcher
    ## 1  A BANERJEE, E DUFLO
    ## 2  A BANERJEE, E DUFLO
    ## 3  A BANERJEE, E DUFLO
    ## 4  A BANERJEE, E DUFLO
    ## 5  A BANERJEE, E DUFLO
    ## 6  A BANERJEE, E DUFLO
    ## 7  A BANERJEE, E DUFLO
    ## 8  A BANERJEE, E DUFLO
    ## 9  A BANERJEE, E DUFLO
    ## 10 A BANERJEE, E DUFLO
    ## 11 A BANERJEE, E DUFLO
    ## 12 A BANERJEE, E DUFLO
    ## 13 A BANERJEE, E DUFLO
    ## 14 A BANERJEE, E DUFLO
    ## 15 A BANERJEE, E DUFLO
    ## 16 A BANERJEE, E DUFLO
    ## 17 A BANERJEE, E DUFLO
    ## 18 A BANERJEE, E DUFLO
    ## 19 A BANERJEE, E DUFLO
    ## 20 A BANERJEE, E DUFLO
    ## 21 A BANERJEE, E DUFLO
    ## 22 A BANERJEE, E DUFLO
    ## 23 A BANERJEE, E DUFLO
    ## 24 A BANERJEE, E DUFLO
    ## 25 A BANERJEE, E DUFLO

``` r
ED[["researcher"]] = toupper(ED[["researcher"]])
filter(select(ED,paperName,researcher), researcher== 'A BANERJEE, E DUFLO')
```

    ##                                                                                                                                           paperName
    ## 1                                                                                                                                addressing absence
    ## 2                                                                                                                      do firms want to borrow more
    ## 3                                                                                  repensar lpobrezun giro radical en lluchcontrldesigualdad global
    ## 4                                                                                                           more th billion people are hungry world
    ## 5                                                                                                                                 repensar lpobreza
    ## 6                                                                                               nature of credit constraints evidence from indibank
    ## 7                                                                                                              improving health care delivery india
    ## 8                                                                                                                              what do banks not do
    ## 9                                                                                                        not so simple economics of lending to poor
    ## 10                                                                                         poor economics radical rethinking of way to fight global
    ## 11                                                                                                 education asymmetry brav brawn rural communities
    ## 12                                                                                dp under thumb of history political institutions scope for action
    ## 13                                                                                                                                  editors journal
    ## 14 開発経済学 development economics いまも 飢餓 に苦しむ多くの人たちを救うことはできるのでしょうか新しい経済学 へようこそnew economics 新しい経済学
    ## 15                                                                                                                 dp giving credit where it is due
    ## 16                                                                                                dp experimental approach to development economics
    ## 17                                                                                        dp what is middle class about middle classes around world
    ## 18                                                                                                                        dp economic lives of poor
    ## 19                                                                                       economic lives of poor development economics public policy
    ## 20                                                        dp do firms want to borrow more testing credit constraints using directed lending program
    ##             researcher
    ## 1  A BANERJEE, E DUFLO
    ## 2  A BANERJEE, E DUFLO
    ## 3  A BANERJEE, E DUFLO
    ## 4  A BANERJEE, E DUFLO
    ## 5  A BANERJEE, E DUFLO
    ## 6  A BANERJEE, E DUFLO
    ## 7  A BANERJEE, E DUFLO
    ## 8  A BANERJEE, E DUFLO
    ## 9  A BANERJEE, E DUFLO
    ## 10 A BANERJEE, E DUFLO
    ## 11 A BANERJEE, E DUFLO
    ## 12 A BANERJEE, E DUFLO
    ## 13 A BANERJEE, E DUFLO
    ## 14 A BANERJEE, E DUFLO
    ## 15 A BANERJEE, E DUFLO
    ## 16 A BANERJEE, E DUFLO
    ## 17 A BANERJEE, E DUFLO
    ## 18 A BANERJEE, E DUFLO
    ## 19 A BANERJEE, E DUFLO
    ## 20 A BANERJEE, E DUFLO

Looking at the journal column of both data frames we can see that the
1st data frame contain 368 unique journals and the 2nd data frame
contains 348 unique journals.

``` r
#Q7 
# This allows us to the number of the unique articles with in each data frame
Unique_journal_AB=length(unique(AB$journal))
Unique_journal_AB
```

    ## [1] 368

``` r
Unique_journal_ED=length(unique(ED$journal))
Unique_journal_ED
```

    ## [1] 348

In this part we can see the overall number of times each journal of
Abhojit Banerjee has been cited and as well as Ester Duflo

``` r
#Q8
# Abhojit Banerjee

# Were able to find each journal and the number of times each one has been cited in each data frame
total_AB_journal_citations=summarise(group_by(AB,journal,citations))
```

    ## Warning: Factor `journal` contains implicit NA, consider using
    ## `forcats::fct_explicit_na`

``` r
total_AB_journal_citations
```

    ## # A tibble: 391 x 2
    ## # Groups:   journal [368]
    ##    journal                                                        citations
    ##    <fct>                                                              <int>
    ##  1 1st TCD/LSE/CEPR Workshop in Development Economics, Dublin, 2…        11
    ##  2 A Research on China’s Economic Growth Potential 46 (1), 1-3, …        NA
    ##  3 A. Robinson. Reversal of fortune: Geography and institutions …        34
    ##  4 ABCDE, 145, 2005                                                      NA
    ##  5 Accessed February 15, 2017, 2014                                      29
    ##  6 Achieving the Millennium Development Goals 33, 230, 2008              NA
    ##  7 Advances in Economics and Econometrics: Theory and Applicatio…       284
    ##  8 AEA Papers and Proceedings 109, 133-37, 2019                           3
    ##  9 AEA Papers and Proceedings 109, 334-39, 2019                          95
    ## 10 African Successes, Volume I: Government and Institutions 1, 4…        NA
    ## # … with 381 more rows

``` r
#Ester Duflo
total_ED_journal_citations=summarise(group_by(ED,journal,citations))
```

    ## Warning: Factor `journal` contains implicit NA, consider using
    ## `forcats::fct_explicit_na`

``` r
total_ED_journal_citations
```

    ## # A tibble: 369 x 2
    ## # Groups:   journal [348]
    ##    journal                                                        citations
    ##    <fct>                                                              <int>
    ##  1 [Rabat Morocco] John Snow [JSI] 2001 Jun 28., 2001                    NA
    ##  2 [Unpublished] 2002. Prepared for the IAEN Economics of HIV/AI…        NA
    ##  3 [Unpublished] 2006 Aug., 2006                                         NA
    ##  4 21st BREAD Conference, 12-13, 2012                                     9
    ##  5 A Radical Rethinking of the Way to Fight Global Poverty. New …         2
    ##  6 A Research on China’s Economic Growth Potential 46 (1), 1-3, …        NA
    ##  7 Accessed February 15, 2017, 2014                                      31
    ##  8 AEA Papers and Proceedings 108, 636-51, 2018                           2
    ##  9 AEA Papers and Proceedings 108, 745, 2018                              2
    ## 10 AEA Papers and Proceedings 109, 612-26, 2019                          NA
    ## # … with 359 more rows

based on the total number of citations of the previous part we can see
that the most reliable journal for these scholars academic fields.

``` r
#Q9
# here we can see what the top citataion is for the journal
most_AB_citations=AB %>% group_by(journal,citations) %>% top_n(n=1) %>% head(1)
```

    ## Warning: Factor `journal` contains implicit NA, consider using
    ## `forcats::fct_explicit_na`

    ## Selecting by year

``` r
most_AB_citations
```

    ## # A tibble: 1 x 5
    ## # Groups:   journal, citations [1]
    ##   paperName           researcher journal                    citations  year
    ##   <chr>               <chr>      <fct>                          <int> <int>
    ## 1 " simple model of … AV BANERJ… The quarterly journal of …      7190  1992

For Abhojit Banerjee the journal “The quarterly journal of economics 107
(3), 797-817, 1992” would be the most influencial with a total of 7190
citations

``` r
most_ED_citations=ED %>% group_by(journal,citations) %>% top_n(n=1) %>% head(1)
```

    ## Warning: Factor `journal` contains implicit NA, consider using
    ## `forcats::fct_explicit_na`

    ## Selecting by year

``` r
most_ED_citations
```

    ## # A tibble: 1 x 5
    ## # Groups:   journal, citations [1]
    ##   paperName             researcher       journal            citations  year
    ##   <chr>                 <chr>            <fct>                  <int> <int>
    ## 1 how much should we t… M BERTRAND, E D… The Quarterly jou…      8865  2004

For Ester Duflo, we can see that the journal, “The Quarterly journal of
economics 119 (1), 249-275, 2004” would also be influencial with a total
of 8865 citations.

Overall it would seem that “The Quarterly journal of economics” is the
most reliable and influencial for these scholars field of study based on
the infomation provided above.
