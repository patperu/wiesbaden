library(readr)
library(tidyverse)
library(wiesbaden)

packageVersion("readr")
packageVersion("wiesbaden")

ad_set <- "https://www.destatis.de/DE/Themen/Laender-Regionen/Regionales/Gemeindeverzeichnis/Administrativ/Archiv/GV100ADQ/GV100AD3QAktuell.zip?__blob=publicationFile"
temp <- tempfile()
download.file(ad_set, temp, mode = "wb")

ad1 <- wiesbaden::read_gv100(unz(temp, "GV100AD_300921.txt"), version = "AD", stzrt = 60, encoding = "UTF-8")
ad2 <- wiesbaden::read_gv100("fix_gv100/GV100AD_300921.txt", version = "AD", stzrt = 60, encoding = "UTF-8")

identical(ad1, ad2)

# Error: encoding default "iso-8859-1"
#   One or more parsing issues, see `problems()` for details 
wiesbaden::read_gv100(unz(temp, "GV100AD_300921.txt"), version = "AD", stzrt = 60)

ad1 %>% tibble() %>% arrange(id) %>% glimpse()

unlink(temp)

##############################################################################

nad_set <- "https://www.destatis.de/DE/Themen/Laender-Regionen/Regionales/Gemeindeverzeichnis/Administrativ-Nicht/Archiv/GV100NADQ/GV100NAD3QAktuell.zip?__blob=publicationFile"

temp <- tempfile()
download.file(nad_set, temp, mode = "wb")

nad1 <- wiesbaden::read_gv100(file = unz(temp, "GV100NAD_300921.txt"), version = "NAD", stzrt = 61, encoding = "UTF-8")
nad2 <- wiesbaden::read_gv100("fix_gv100/GV100NAD_300921.txt", version = "NAD", stzrt = 61, encoding = "UTF-8")

identical(nad1, nad2)

nad1 %>% tibble() %>% arrange(id) %>% glimpse()

unlink(temp)
