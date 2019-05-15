##This is a code which creates a matrix and computes inverse of the Matrix. 
##If the inverse is already computed, the result is stored in the Cache and can be re-used from the Cache.
##This prevents the re-computation of Inverse and saves program resources as computing the Inverse of a Matrix can
##be a time consuming task. 
##**This code explains the practical behaviour of Lexical scoping in R.**##

##The cachematrix.R contains two functions, makeCacheMatrix() and cacheSolve(). The first function, makeCacheMatrix()
##creates an R object that stores a matrix and its inverse. The second function cacheSolve() requires an argument
##that is returned by makeCacheMatrix() in order to retrieve the inverse from the cached value that is stored in 
##the makeCacheMatrix() object's environment.
###################################################################################################################


##MakeCacheMatrix() builds a set of functions and returns the functions within a list to the parent environment.
##Function call - mymatrix <- makeCacheMatrix(matrix(c(1/2, -1/4, -1, 3/4), nrow = 2, ncol = 2))
##This results in an object, mymatix, that contains for functions: set(), get(), setinv(), getinv(). It also includes
##two data objects, x and inv

makeCacheMatrix <- function(x = matrix()) {
  inv <- NULL
  set <- function(z){
    x <<- z
    inv <- NULL
  }
  get <- function() x
  setinv <- function(iINV) inv <<- iINV
  getinv <- function() inv
  list(set = set, get = get, setinv = setinv, getinv = getinv)

}


##cacheSolve() is required to populate and/or retieve the inverse from an object of type makeCacheMatrix()
##Function call - cacheSolve(mymatrix)
##x$getinv() checks if the inverse of x is already calculate. If this value is not NULL, then the already computed
##inverse is returned. Otherwise, solve() function is called on the input matrix to compute the inverse.

cacheSolve <- function(x, ...) {
  inv <- x$getinv()
  if(!is.null(inv)){
    message("Getting cached data")
    return(inv)
  }
  data <- x$get()
  inv <- solve(data, ...)
  x$setinv(inv)
  inv
        ## Return a matrix that is the inverse of 'x'
}
