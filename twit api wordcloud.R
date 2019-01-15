getwd()
install.packages(c("twitteR","ROAuth","base64enc"))
library(base64enc)
library(ROAuth)
library(twitteR)
install.packages("installr")
library(installr)
#consumerKey <- "Consumer Key (API Key)"

#consumerSecret <- "Consumer Secret (API Key)"

#AccessToken <- "Access Token"

#accessTokenSecret <- "Access Token Secret"
api_key <- "S9vPnYxtUZj8UFIDuc7uyQ7px"

api_secret <- "8rmqvkBijlaRdo9dhxIajPMhUeoQF6N3pWMdUiP4cuSZmyLc2k"

access_token <- "1078110732200202240-YsO64SM6eAxXIJyzss7vXOHBqyCvaP"

access_token_secret <- "0FixTgvdCYaaSnvmXcv76JWZ9Z8rkJDz6I0uux4GqhdEW"


setup_twitter_oauth(api_key, api_secret, access_token, access_token_secret)


keyword <- enc2utf8("맥주")
keyword <- enc2utf8("혼맥")


je <- searchTwitter(keyword, n=500, lang="ko")
length(je)
head(je)


## textmining

install.packages("rJava")
install.packages("memoise")
install.packages("KoNLP")

library(KoNLP)
install.packages("dplyr")
library(dplyr)

useNIADic()

txt2 <- je
head(txt2)

## 트윗 결과 중에서 텍스트에 해당하는 부분만 추출 ***트윗 명사 추출시 포인트!
result2.df <- twListToDF(txt2)
head(result2.df)
result2.text <- result2.df$text
head(result2.text)

result2.text <- gsub("+","", result2.text)
result2.text <- gsub("맥주","", result2.text)
result2.text <- gsub("무대","", result2.text)
result2.text <- gsub("철판","", result2.text)
result2.text <- gsub("하나","", result2.text)
result2.text <- gsub("자판기","", result2.text)
result2.text <- gsub("맨뒤","", result2.text)
result2.text <- gsub("오류났나봐","", result2.text)
result2.text <- gsub("됐던거","", result2.text)
result2.text <- gsub("될수있","", result2.text)
result2.text <- gsub("깔지","", result2.text)
result2.text <- gsub("될수있","", result2.text)


result2.text <- gsub("^","", result2.text)
result2.text <- gsub("ㅅ","", result2.text)
result2.text <- gsub("ㅋ","", result2.text)
result2.text <- gsub("개쩐","", result2.text)

result2.text <- gsub("^ㅅ","", result2.text)
result2.text <- gsub("^ㅂ","", result2.text)
result2.text <- gsub("ㅂ","", result2.text)
result2.text <- gsub("^ ㅂ","", result2.text)
result2.text <- gsub("^ㅋ","", result2.text)

result2.text <- gsub("도","", result2.text)
result2.text <- gsub("머","", result2.text)
result2.text <- gsub("씨발","", result2.text)


result2.text <- gsub("\n", "", result2.text)
result2.text <- gsub("\r", "", result2.text)
result2.text <- gsub("RT", "", result2.text)
result2.text <- gsub("http", "", result2.text)
result2.text <- gsub("CO", "", result2.text)
result2.text <- gsub("co", "", result2.text)

result2.text <- gsub("ㅋㅋ", "", result2.text)
result2.text <- gsub("ㅋㅋㅋ", "", result2.text)
result2.text <- gsub("ㅋㅋㅋㅋ", "", result2.text)
result2.text <- gsub("ㅠㅠ", "", result2.text)
result2.text <- gsub("ㅜ", "", result2.text)
result2.text <- gsub("ㅜㅜ", "", result2.text)

result2.text <- gsub("[a-z,A-Z]+","",result2.text) ## 영문 제거 문법
result2.text <- gsub('\\d+',"",result2.text)   ## 숫자 제거 문법
result2.text <- gsub("[^\uAC00-\uD7A3xfe a-zA-Zㄱ-ㅎㅏ-ㅣ가-힣\\s]", "", result2.text)
result2.text <- str_replace_all(result2.text,"[A-Za-z0-9]","")
result2.text <- gsub("[~!@#$%&*()_+=?<>]", "", result2.text)

result2.text



txt2 <- result2.text
nouns2 <- extractNoun(txt2)

# 추출한 명사 list를 문자열 벡터로 변환, 단어별 빈도표 생성
wordcount2 <- table(unlist(nouns2))

# 데이터 프레임으로 변환
df_word2 <- as.data.frame(wordcount2, stringsAsFactors = F)



# 변수명 수정
df_word2 <- rename(df_word2,
                   word = Var1,
                   freq = Freq)



# 두 글자 이상 단어 추출

df_word2 <- filter(df_word2, nchar(word) >= 2)

top2_100 <- df_word2 %>%
  arrange(desc(freq)) %>%
  head(100)

top2_100



# 패키지 로드
install.packages(c("wordcloud2","RColorBrewer"))
library(wordcloud2)
library(RColorBrewer)
install.packages(c("tm","slam"))
library(NLP)
library(tm)
library(slam)

# 워드 클라우드 만들기

#워드 클라우드2 이용
wordcloud2(data = df_word2)
wordcloud2(data = top2_100)