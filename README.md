PS 239T Final Project

Demetria McAleer

## Short Description

This project webscraped Wikipedia to get ideologies of 578 rebel groups in civil wars.  I did this by creating URLs to run a Google search for each rebel group's Wikipedia page, then saving the first link.  Then I loop through the links to go to each Wikipedia page, check to make sure it is a Wikipedia page and formatted as expected, and use Beautiful Soup to parse the results.  I find the box in the upper right hand corner of each page using HTML tags, find the row for ideology, and save the results.

Unfortunately, it turned out that not all the Wiki pages were formatted in the same way, so I wound up with only 129 ideologies.  So, for the second part of the project, I went back and scraped the content of the Wikipedia pages, and used clustering and structural topic modeling in R to analyze the content on the usable Wikipedia pages.

## Dependencies

1. Python 2.7, Anaconda distribution.
2. R 3.2.2


## Files


### Data

1. "search_terms.csv": List of rebel groups and governments.  Taken from Cunningham, Gleditsch, and Salehyan (2013) Non-State Actor Data (available http://privatewww.essex.ac.uk/~ksg/eacd.html).  A few names have been changed from the original dataset to remove special characters/accent marks.
2. "content-ideo.csv": Results from Wikipedia scrape, for analysis in R.

### Code

1. 01_wiki-scrape.ipynb: Collects data from Wikipedia pages and exports to CSV.
2. 02_text-analysis.R: Text analysis and visualizations in R.

### Results

1. crazy_dendrogram.jpeg: Cluster dendrogram on content of Wikipedia pages.
2. stm.jpeg: Structural topic model of content of Wikipedia pages.

## More Information

Demetria McAleer

PhD Student, UC Berkeley

dfmcaleer@berkeley.edu
