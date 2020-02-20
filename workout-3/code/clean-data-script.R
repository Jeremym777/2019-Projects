
##clean data script

library(rvest)
setwd("~/Desktop/Stat133/workouts/workout3/data/")
parent_data1 = read_html('rawdata/abhijit_banerjee_GoogleScholarCitations.html')

parent_data2 = read_html("rawdata/esther_duflo_GoogleScholarCitations.html")

## 1 Extracting Basic Information of The Authors

# Abhojit Banerjee

# extracting names of authors from html

author1=parent_data1 %>% html_nodes(xpath = '//*[@id="gsc_prf_in"]') 

author1_name= author1 %>% html_text(author1)
author1_name

# Esther Duflo
author2 = parent_data2 %>% html_nodes(xpath="//*[@id='gsc_prf_in']") 

author2_name= author2 %>% html_text(author2)
author2_name

## Affililated Insitutions

# extracting scholars' affililated insitutions

# economics


school1=parent_data1 %>% html_nodes(xpath = '//*[@class="gsc_prf_inta gs_ibl"]')

school1_name=school1%>% html_text(school1)
school1_name


# MIT
school2 = parent_data2 %>% html_nodes(xpath = "//*[@class='gsc_prf_ila']")

school2_name = school2 %>% html_text(school2)
school2_name


#2 Extract all the papers for each author

# Abhijit Banerjee Dataframe

#495
paperName1=c( parent_data1 %>% html_nodes(xpath = '//*[@class="gsc_a_t"]') %>% html_nodes(xpath = '//*[@class="gsc_a_t"]') %>% html_nodes('a') %>% html_nodes(xpath = '//*[@class="gsc_a_at"]') %>% html_text())

#495
researcher1= c( parent_data1 %>% html_nodes(xpath = '//*[@class="gsc_a_t"]') %>% html_nodes(xpath = '//*[@class="gsc_a_t"]') %>% html_nodes('div') %>% html_text())
researcher1 = researcher1[seq(1,length(researcher1),2)]

#495
journal1 = c( parent_data1 %>% html_nodes(xpath = '//*[@class="gsc_a_t"]') %>% html_nodes(xpath = '//*[@class="gsc_a_t"]') %>% html_nodes('div') %>% html_text())
journal1=journal1[seq(2,length(journal1),2)]


citations1=c( parent_data1 %>% html_nodes(xpath = '//*[@class="gsc_a_t"]')  %>% html_nodes(xpath = '//*[@class="gsc_a_c"]') %>% html_nodes('a') %>% html_text())
citations1 = citations1[seq(1,length(citations1)-1)]
citations1 =as.integer(citations1)

year1= c(parent_data1 %>% html_nodes(xpath = '//*[@id="gsc_a_b"]') %>% html_nodes("tr") %>% html_nodes(xpath = '//*[@class="gsc_a_y"]') %>% html_text())

year1= year1[seq(3,length(year1))]
year1 = as.numeric(gsub(",","",year1))


AB= data.frame(paperName=paperName1,researcher=researcher1, journal=journal1,citations=citations1,year=year1)
AB[AB ==""]=NA




# Esther Duflo Dataframe

paperName2=c( parent_data2 %>% html_nodes(xpath = '//*[@class="gsc_a_t"]') %>% html_nodes(xpath = '//*[@class="gsc_a_t"]') %>% html_nodes('a') %>% html_nodes(xpath = '//*[@class="gsc_a_at"]') %>% html_text())


researcher2= c( parent_data2 %>% html_nodes(xpath = '//*[@class="gsc_a_t"]') %>% html_nodes(xpath = '//*[@class="gsc_a_t"]') %>% html_nodes('div') %>% html_text())
researcher2 = researcher2[seq(1,length(researcher2),2)]


journal2 = c( parent_data2 %>% html_nodes(xpath = '//*[@class="gsc_a_t"]') %>% html_nodes(xpath = '//*[@class="gsc_a_t"]') %>% html_nodes('div') %>% html_text())
journal2=journal2[seq(2,length(journal2),2)]


citations2=c( parent_data2 %>% html_nodes(xpath = '//*[@class="gsc_a_t"]') %>% html_nodes(xpath = '//*[@class="gsc_a_c"]') %>% html_nodes('a') %>% html_text())
citations2 = citations2[seq(1,length(citations2)-3)]
citations2 = as.integer(citations2)

year2= c(parent_data2 %>% html_nodes(xpath = '//*[@id="gsc_a_b"]') %>% html_nodes("tr") %>% html_nodes(xpath = '//*[@class="gsc_a_y"]') %>% html_text())
year2= year2[seq(3,length(year2))]
year2 = as.numeric(gsub(",","",year2))

ED=data.frame(paperName=paperName2,researcher= researcher2,journal=journal2, citations = citations2, year = year2)
ED[ED==""]=NA


# creating csv files for Nobel Laureates
write.csv(AB,'cleandata/Abhijit_Banerjee.csv')
write.csv(ED, 'cleandata/Esther_Duflo.csv')

