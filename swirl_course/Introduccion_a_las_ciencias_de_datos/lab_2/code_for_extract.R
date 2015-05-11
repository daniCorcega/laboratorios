## @knitr req_pkgs
# Paquetes necesarios para la extraccion de los siguientes formatos: (xml,html.xlsx)
 install.packages("curl")
 install.packages("data.table")
 install.packages("XML")
 install.packages("plyr")
 install.packages("xlsx")
 install.packages("sqldf")
 
 #CMD:
 # R CMD javareconfig
 # sudo apt-get install liblzma-dev
 # sudo apt-get install libxml2-dev
 
 install.packages("DBI")
 
 # CMD:
 # sudo apt-get install mysql-server
 # sudo apt-get install mysql-client
 # sudo apt-get install libmysqlclient-dev
 
 install.packages("RMySQL")
## @knitr end_chunk


## @knitr req_libs
 library("plyr")
 library("data.table")
 library("curl")
 library("RMySQL")
 library("xlsx")
 library(XML)
 library(jsonlite)
 library(data.table)
 library("rhdf5")
## @knitr set_dir
 if (!file.exists("data")){
  dir.create("data")
}
## @knitr end_chunk
 
## @knitr for_csv
 fileUrl <- "http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"
 fileDest <- "./data/raw2.xml"
 download.file(fileUrl, destfile = fileDest)
 list.files("./data")
 data<-read.csv2(fileDest, header=TRUE,sep=',')
 dateDownloaded <- date()
## @knitr end_chunk
 
## @knitr for_xls
#library(xlsx)
 raw <- read.xlsx("./data/raw1.xlsx",sheetIndex=1,header=TRUE)
# for reading specifics columns and rows
#example:
 colIndex <- 2:3
 rowIndex <- 1:4
 dataSubset <- read.xlsx("./data/raw.xlsx",sheetIndex=1, colIndex = colIndex, rowIndex = rowIndex)
## @knitr end_chunk
 
## @knitr for_xml
#library(XML)
 fileUrl <- "url"
 doc <- xmlTreeParse(fileDest, useInternal= TRUE)
 rootNode <- xmlRoot(doc)
 xmlName(rootNode) 
# se accede como una lista:
 rootNode[[1]] #primer elemento
 rootNode[[1]][[1]] #primer campo del primer elemento
 xmlSApply(rootNode,xmlValue) #aplica a todos los campos partiendo de un arbol la funcion del 2do campo.
 xmlSApply(rootNode, "zipcode", xmlValue) #a todos los campos name xmlValue
#	Contenido por atributos:(desde html)
 file <- "html-url"
 doc <- htmlTreeParse(file, useInternal=TRUE)
 scores <- xpathSApply(doc, "//li[@class='score']", xmlValue)
## @knitr end_chunk

 
## @knitr for_JSON
#library(jsonlite)
 jsonData <- fromJSON(json-url)
# pasar a json:
 myjosn <- toJSON(source, pretty = TRUE)
 cat(myjson) print it out)
## @knitr end_chunk

## @knitr for_datatable
#library(data.table)
 DT = data.table
 DT[2,] #subsetting rows solo 2 rows
 DT[c(i,j)] #solo los rows i , j
 DT[,c(i,j)] #solo las columnas i , j
# sumas coolumnas  DT[,w:=z^2]
 DT2 <- DT
# luego DT[,z:=y^2] cambia los 2 data.table
# varias op DT[,z:={tmp<-(x+y);log2(tmp+5)}]
# tambien pueden ser logicas DT[,z:=x>0]
# don DT[, .N by=x] agrupa por valores de x y dice cuantos hay de cada uno
# setkey(DT, x) ahora el key del data set es x
# asi seria subsetting por el valor a DT['a']
# Merging
 DT1<- data.table(x=c('a','a','b','c'), y=1:4)
 DT2<- data.table(x=c('a','a','sds'), z=2:7)
 setkey(DT1,x); setkey(DT2, x)
 merge(DT1,DT2)
 #fread() #es mas rapido que read.table()
 bigDf<- data.frame(x=rnorm(1E6), y=rnorm(1E6))
 file <- tempfile()
 write.table(bigdf,file=file,row.names=FALSE,col.names=TRUE,sep='\t',quote=FALSE)
 system.time(fread(file))
 system.time(read.table(file,header=TRUE,sep='\t'))

## @knitr for_mysql
#library("RMySQL")
 ucscDb <- dbConnect(MySQL(), user = "genome", host = "genome-mysql.cse.ucsc.edu")
# or an specific database
 hg19 <- dbConnect(MySQL(), user = "genome", db = "hg19", host = "genome-mysql.cse.ucsc.edu")
 result <-dbGetQuery(ucscDb, "show databases;"); dbDisconnect(ucscDb)
 allTables <- dbListTables(hg19)
 length(allTables)
# length de cada tabla
 dbListFields(hg19, "affyU133Plus2")
 dbGetQuery(hg19, "select count (*) from affyU133Plus2")
 tabla = dataframe
 affyData <- dbReadTable(hg19, "affyU133Plus2")
 head(affyData)
# Subsetting
 query <- dbSendQuery(hg19,"select * from affyU133Plus2 where misMatches between 1 and 3")
 affMis <- fetch(query) ; quantile(affyMis$misMatches)
 affyMisSmall <- fetch(query, n=10) ; dbClearResult(query);# cleaning the query 
# Query commands: http://www.pantz.org/software/mysql/mysqlcommands.html
# de r-blogger: http://www.r-bloggers.com/mysql-and-r/
## @knitr end_chunk
 
## @knitr for_hdf5
# library("rhdf5")
#heirarchical data format more info http://hdfgroup.org/HDF5/whatishdf5.html
 source("http://bioconductor.org/biocLite.R")
 biocLite("rhdf5")
 created = h5createfile("example.h5")
 created = h5createGroup("example.h5", "foo")
 created = h5createGroup("example.h5", "baa")
 created = h5createGroup("example.h5", "foo/foobaa")
 h5ls("example.h5")
# writing on a group 
 A = some_data
 h5write(A,"example.h5","foo/A")
 h5ls("exampl.h5")
 readA = h5read("example.h5","foo/A")
# writing chunk in a specific index example
 h5write(c(12,23,43),"example.h5","foo/A",index = list(1:3,1))
 h5read("example.h5","foo/A")
# efficient read/write from disk in R
## @knitr end_chunk
 

## @knitr web_scrapping
 con = url("http://scholar.google.com/citations?user=HI-I6C0AAAAJ&hl=en")
 htmlCode= readLines(con)
 close(con)
 htmlCode
# Or
#library(XML)
 url <- "http://scholar.google.com/citations?user=HI-I6C0AAAAJ&hl=en"
 html <- htmlTreeParse(url,useInternalNodes=T)  
 xpathSApply(html, "//title", xmlValue)
#library(httr); 
 html2 = GET(url)
 content2 = content(html2,as = "text")
 parsedHtml = htmlParse(content2,asText=TRUE)
 xpathSApply(parsedHtml,"//title", xmlValue)
# Or
 pg2 = GET("http://httpbin.org/basic-auth/user/passwd", authenticate("user","passw"))
 pg2
## @knitr end_chunk

 
## @knitr tw_api

 myapp = oauth_app("twitter",
                   key="yourConsumerKeyHere",secret="yourConsumerSecretHere")
 sig = sign_oauth1.0(myapp,
                     token = "yourTokenHere",
                     token_secret = "yourTokenSecretHere")
 homeTL = GET("https://api.twitter.com/1.1/statuses/home_timeline.json", sig)
 json1 = content(homeTL)
 json2 = jsonlite::fromJSON(toJSON(json1))
 json2[1,1:4]

## @knitr for_github
#library(httr)
#install.packages("httpuv")
#library(httpuv)
 oauth_endpoints("github")
# 2. Register an application at https://github.com/settings/applications;
# Use any URL you would like for the homepage URL (http://github.com is fine)
# and http://localhost:1410 as the callback url
#
# Insert your client ID and secret below - if secret is omitted, it will
# look it up in the GITHUB_CONSUMER_SECRET environmental variable.
 secret <- ""
 myapp <- oauth_app("github", GITHUB_CONSUMER_SECRET )
# 3. Get OAuth credentials
 github_token <- oauth2.0_token(oauth_endpoints("github"), myapp)
# 4. Use API
 gtoken <- config(token = github_token)
 req <- GET("https://api.github.com/rate_limit", gtoken)
 stop_for_status(req)
 content(req)
# OR:
 req <- with_config(gtoken, GET("https://api.github.com/rate_limit"))
 stop_for_status(req)
 content(req)
## @knitr end_chunk

## @knitr subset
 set.seed(13435)
 X <- data.frame("var1"=sample(1:5),"var2"=sample(6:10),"var3"=sample(11:15))
 X <- X[sample(1:5),]; X$var2[c(1,3)]=NA
 X
#and y or
 X[(X$var1<= 3 & X$var2 > 11),]
 X[(X$var1<= 3 | X$var2 > 11),]
#sorting
 sort(X$var2,decreasing = T)
 sort(X$var2,na.last = T)
#ordering
 X[order(X$var2),]
# ordering with plyr
#library(plyr)
 arrange(X,var2)
 arrange(X,desc(var2))
# adding
 Y <- cbind(X,rnorm(5))
# summarizing
 quantile(restData$councilDistrict,probs=c(0.5,0.75,0.9))
 table(restData$councilDistrict,useNa="ifany")
 table(restData$councilDistrict,resData$zipCode)
# summarizing NA
 sum(is.na(Data$row))
#or
 any(is.na(DAta$row))
# columns based
 all(colSums(is.na(restData))==0) # ?
# kind of SQL
 table(rest$ZipCode %in% c("2222","1111")) # summarizing regs where ZipCodes are the shown
 rest[rest$ZipCode %in% c("2222","1111"),] # showing off
#cross tabs
 xt <- xtabs(Freq ~Gender + Admit, data=DF)
#object size
 print(object.size(fakeData),units="Mb")
## @knitr end_chunk



