library(Rcpp)
library(rbenchmark)


## is odd function in R
## default practice: is to use x mod 2
isOddR <- function(x){
    result <- (x %% 2L == 1L)
}

## same story, but in C++ 
## is statically-typed, hence we need to
## explicitely declare the type of variable
cppFunction("
bool isOddCpp(int num) {
    bool result = (num % 2 == 1);
    return result;
}")

replications <- seq_along(1:3)
replications

for (r in seq_along(replications)){

df <- benchmark("isOddR" = {isOddR(1)}, 
                "isOddCpp" = {isOddCpp(1)},
replications = r,
columns = c("test", "replications", "elapsed"))

rbind(df)    
}

benchmark_table