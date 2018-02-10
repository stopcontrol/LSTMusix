
#start clean
rm(list=ls())

#install and load packages
for (package in c("keras", "readr", "stringr", "purrr", "tokenizers", "tictoc")) {
  if (!require(package, character.only = TRUE, quietly = TRUE)) {
    install.packages(package)
    library(package, character.only = TRUE)
  }
}

system('mkdir ~/musix')
setwd('~/musix/')

#Stringified MIDI File of "FÜR ELISE" ...... Mapping and Corpus of Notes TBA
data <- read.csv2(text="E5_6 D#5_6 E5_6 D#5_6 E5_6 B4_6 D5_6 C5_6 A4_6 E4_6 A4_6 C4_6 E4_6 A4_6 B4_6 E4_6 G#4_6 E4_6 G#4_6 B4_6 C5_6 E4_6 A4_6 E4_6 E5_6 D#5_6 E5_6 D#5_6 E5_6 B4_6 D5_6 C5_6 A4_6 E4_6 A4_6 C4_6 E4_6 A4_6 B4_6 E4_6 G#4_6 E4_6 C5_6 B4_6 A4_6 E4_6 A4_6 E4_6 A4_6 E4_6 A4_6 B4_6 C5_6 D5_6 E5_6 G4_6 C5_6 G4_6 F5_6 E5_6 D5_6 G4_6 B4_6 F4_6 E5_6 D5_6 C5_6 E4_6 A4_6 E4_6 D5_6 C5_6 B4_6 E4_6 E5_6 E4_6 E5_6 E4_6 E5_6 E5_6 E6_6 D#5_6 E5_6 D#5_6 E5_6 D#5_6 E5_6 D#5_6 E5_6 D#5_6 E5_6 D#5_6 E5_6 B4_6 D5_6 C5_6 A4_6 E4_6 A4_6 C4_6 E4_6 A4_6 B4_6 E4_6 G#4_6 E4_6 G#4_6 B4_6 C5_6 E4_6 A4_6 E4_6 E5_6 D#5_6 E5_6 D#5_6 E5_6 B4_6 D5_6 C5_6 A4_6 E4_6 A4_6 C4_6 E4_6 A4_6 B4_6 E4_6 G#4_6 E4_6 C5_6 B4_6 A4_6 E4_6 A4_6 B4_6 C5_6 D5_6 A4_6 E4_6 A4_6 C5_6 C5_6 C5_6 C5_6 A4_6 C5_6 A4_6 F5_9 E5_3 E5_6 A#4_6 D5_6 A#4_6 A#5_9 A5_3 A5_6 G5_6 F5_6 E5_6 D5_6 C5_6 A#4_6 A4_6 A4_6 A4_6 A#5_undefined A4_3 G4_3 A4_3 A#4_3 C5_6 A4_6 C5_6 A4_6 D5_6 D#5_6 E5_6 A4_6 C5_6 E5_6 F5_6 A4_6 C5_12 D5_3 C5_3 B4_3 C5_3 D5_9 B4_3 C5_6 G4_6 A4_6 B4_6 C5_6 D5_6 E5_3 G5_3 C6_3 B5_3 A5_3 G5_3 F5_3 E5_3 D5_3 G5_3 F5_3 D5_3 C5_6 G4_6 A4_6 B4_6 C5_6 D5_6 E5_3 G5_3 C6_3 B5_3 A5_3 G5_3 F5_3 E5_3 D5_3 G5_3 F5_3 D5_3 E5_3 F5_3 E5_3 D#5_3 E5_3 B4_3 E5_3 D#5_3 E5_3 B4_3 E5_3 D#5_3 E5_18 B4_6 E5_6 D#5_6 E5_18 B4_6 E5_6 D#5_6 E5_6 D#5_6 E5_6 D#5_6 E5_6 D#5_6 E5_6 D#5_6 E5_6 B4_6 D5_6 C5_6 A4_6 E4_6 A4_6 C4_6 E4_6 A4_6 B4_6 E4_6 G#4_6 E4_6 G#4_6 B4_6 C5_6 E4_6 A4_6 E4_6 E5_6 D#5_6 E5_6 D#5_6 E5_6 B4_6 D5_6 C5_6 A4_6 E4_6 A4_6 C4_6 E4_6 A4_6 B4_6 E4_6 G#4_6 E4_6 C5_6 B4_6 A4_6 E4_6 A4_6 B4_6 C5_6 D5_6 E5_6 G4_6 C5_6 G4_6 F5_6 E5_6 D5_6 G4_6 B4_6 F4_6 E5_6 D5_6 C5_6 E4_6 A4_6 E4_6 D5_6 C5_6 B4_6 E4_6 E5_6 E4_6 E5_6 E4_6 E5_6 E5_6 E6_6 D#5_6 E5_6 D#5_6 E5_6 D#5_6 E5_6 D#5_6 E5_6 D#5_6 E5_6 D#5_6 E5_6 B4_6 D5_6 C5_6 A4_6 E4_6 A4_6 C4_6 E4_6 A4_6 B4_6 E4_6 G#4_6 E4_6 G#4_6 B4_6 C5_6 E4_6 A4_6 E4_6 E5_6 D#5_6 E5_6 D#5_6 E5_6 B4_6 D5_6 C5_6 A4_6 E4_6 A4_6 C4_6 E4_6 A4_6 B4_6 E4_6 G#4_6 E4_6 C5_6 B4_6 A4_12 P_24 C#5_36 D5_24 E5_6 F5_6 F5_24 F5_12 E5_36 D5_24 C5_6 B4_6 A4_24 A4_12 A4_12 C5_12 B4_12 A4_36 C#5_36 D5_24 E5_6 F5_6 F5_24 F5_12 F5_36 D#5_24 D5_6 C5_6 A#4_24 A4_12 G#4_24 G#4_12 A4_24 P_12 B4_12 P_12 P_12 A3_4 C4_4 E4_4 A4_4 C5_4 E5_4 D5_4 C5_4 B4_4 A4_4 C5_4 E5_4 A5_4 C6_4 E6_4 D6_4 C6_4 B5_4 A5_4 C6_4 E6_4 A6_4 C7_4 E7_4 D7_4 C7_4 B6_4 A#6_4 A6_4 G#6_4 G6_4 F#6_4 F6_4 E6_4 D#6_4 D6_4 C#6_4 C6_4 B5_4 A#5_4 A5_4 G#5_4 G5_4 F#5_4 F5_4 E5_6 D#5_6 E5_6 B4_6 D5_6 C5_6 A4_6 E4_6 A4_6 C4_6 E4_6 A4_6 B4_6 E4_6 G#4_6 E4_6 G#4_6 B4_6 C5_6 E4_6 A4_6 E4_6 E5_6 D#5_6 E5_6 D#5_6 E5_6 B4_6 D5_6 C5_6 A4_6 E4_6 A4_6 C4_6 E4_6 A4_6 B4_6 E4_6 G#4_6 E4_6 C5_6 B4_6 A4_6 E4_6 A4_6 B4_6 C5_6 D5_6 E5_6 G4_6 C5_6 G4_6 F5_6 E5_6 D5_6 G4_6 B4_6 F4_6 E5_6 D5_6 C5_6 E4_6 A4_6 E4_6 D5_6 C5_6 B4_6 E4_6 E5_6 E4_6 E5_6 E4_6 E5_6 E5_6 E6_6 D#5_6 E5_6 D#5_6 E5_6 D#5_6 E5_6 D#5_6 E5_6 D#5_6 E5_6 D#5_6 E5_6 B4_6 D5_6 C5_6 A4_6 E4_6 A4_6 C4_6 E4_6 A4_6 B4_6 E4_6 G#4_6 E4_6 G#4_6 B4_6 C5_6 E4_6 A4_6 E4_6 E5_6 D#5_6 E5_6 D#5_6 E5_6 B4_6 D5_6 C5_6 A4_6 E4_6 A4_6 C4_6 E4_6 A4_6 B4_6 E4_6 G#4_6 E4_6 C5_6 B4_6 C4_24 A4_24 P_24",sep = " ", quote = "", header=FALSE, stringsAsFactors = FALSE)
data <- t(data)
data_vector <- as.vector(data)
data_dict <- unique(data_vector)
data_dict <- sort(data_dict)

data_vector_encoded <- c()
for (i in data_vector){
  ind  <-  which(data_dict == i)
  data_vector_encoded <- append(data_vector_encoded, ind)
}

#length of a single batch  
maxlen <- 16

# Load, collapse, and tokenize song
text <- read_lines(path) %>%
  str_to_lower() %>%
  str_c(collapse = "\n") %>%
  tokenize_characters(strip_non_alphanum = FALSE, simplify = TRUE)

print(sprintf("corpus length: %d", length(text)))
text <- data_vector
chars <- text %>%
  unique() %>%
  sort()

print(sprintf("total characters: %d", length(chars)))  

# Cut the text in semi-redundant sequences of maxlen characters
dataset <- map(
  seq(1, length(text) - maxlen - 1, by = 3), 
  ~list(sentece = text[.x:(.x + maxlen - 1)], next_char = text[.x + maxlen])
)

dataset <- transpose(dataset)

# Vectorization
X <- array(0, dim = c(length(dataset$sentece), maxlen, length(chars)))
y <- array(0, dim = c(length(dataset$sentece), length(chars)))

for(i in 1:length(dataset$sentece)){
  
  X[i,,] <- sapply(chars, function(x){
    as.integer(x == dataset$sentece[[i]])
  })
  
  y[i,] <- as.integer(chars == dataset$next_char[[i]])
  
}

# Define keras/tensorflow model

model <- keras_model_sequential()

model %>%
  layer_lstm(128, input_shape = c(maxlen, length(chars))) %>%
  layer_dense(length(chars)) %>%
  layer_activation("softmax") #play with activation layers

optimizer <- optimizer_rmsprop(lr = 0.01)

model %>% compile(
  loss = "categorical_crossentropy", 
  optimizer = optimizer
)

# Training the network

sample_mod <- function(preds, temperature = 1){
  preds <- log(preds)/temperature
  exp_preds <- exp(preds)
  preds <- exp_preds/sum(exp(preds))
  
  rmultinom(1, 1, preds) %>% 
    as.integer() %>%
    which.max()
}

for(iteration in 1:60){
  
  cat(sprintf("iteration: %02d ---------------\n\n", iteration))
  
  model %>% fit(
    X, y,
    batch_size = 128,
    epochs = 1
  )
  
  for(diversity in c(0.2, 0.5, 1, 1.2)){
    
    cat(sprintf("diversity: %f ---------------\n\n", diversity))
    
    start_index <- sample(1:(length(text) - maxlen), size = 1)
    sentence <- text[start_index:(start_index + maxlen - 1)]
    generated <- ""
    
    for(i in 1:400){
      
      x <- sapply(chars, function(x){
        as.integer(x == sentence)
      })
      x <- array_reshape(x, c(1, dim(x)))
      
      preds <- predict(model, x)
      next_index <- sample_mod(preds, diversity)
      next_char <- chars[next_index]
      
      generated <- str_c(generated, next_char, collapse = "")
      sentence <- c(sentence[-1], next_char)
      
    }
    
    cat(generated)
    cat("\n\n")
    
  }
}
