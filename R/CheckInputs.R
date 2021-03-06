CheckInputs <- function(train, valid, trt, y, crossval){
  
  if (is.null(train)){
    stop("ERROR: Have to supply a traning dataset")
  }
  
  if (nrow(train)==0){
    stop("ERROR: No observations in the training dataset")    
  }
  
  if (class(train) != "data.frame"){
    stop("ERROR: Training dataset has to be of type data.frame")
  }  
  
  if (crossval==TRUE){
    if (class(valid) != "data.frame"){
      stop("ERROR: Validation dataset has to be of type data.frame")
    }  
    if (nrow(valid)==0){
      stop("ERROR: No observations in the validation dataset")    
    }
    if (!(y %in% names(valid))){
      stop(paste0("ERROR: Dependent variable ", y, " not found in the input validation data frame"))    
    }
  }
  
  if (!(y %in% names(train))){
    stop(paste0("ERROR: Dependent variable ", y, " not found in the input training data frame"))    
  }
  
  if (any(is.na(train[[y]]))){
    stop(paste0("ERROR: Dependent variable ", y, " has NAs in the input training data frame"))        
  } 
  
  if (is.null(trt)==FALSE){
    if (!(trt %in% names(train))){
      stop(paste0("ERROR: Treatment indicator ", trt, " not found in the input training data frame"))        
    }
    if (crossval==TRUE){
      if (!(trt %in% names(valid))){
        stop(paste0("ERROR: Treatment indicator ", trt, " not found in the input validation data frame"))        
      }
    }
  }
  
  if (is.factor(train[[y]])){
    stop(paste0("ERROR: The dependent variable ", y, " is a factor in training dataset"))
  }  
  
  if (crossval==TRUE){
    if (is.factor(valid[[y]])){
      stop(paste0("ERROR: The dependent variable ", y, " is a factor in validation dataset"))
    }  
    if (is.character(valid[[y]])){
      stop(paste0("ERROR: The dependent variable ", y, " is a character variable in either the validation dataset. It has to be numeric"))
    }  
    if (!is.binary(valid[[y]])){
      stop(paste0("ERROR: The dependent variable has to be binary. Check your training and validation datasets."))
    }
    if (any(is.na(valid[[y]]))){
      stop(paste0("ERROR: Dependent variable ", y, " has NAs in the input validation data frame"))        
    }
  }
  
  if (is.character(train[[y]])){
    stop(paste0("ERROR: The dependent variable ", y, " is a character variable in either the training dataset. It has to be numeric"))
  }  
  
  if (!is.binary(train[[y]])){
    stop(paste0("ERROR: The dependent variable has to be binary. Check your training and validation datasets."))
  }
  
  if (is.null(trt)==FALSE){
    if (is.factor(train[[trt]])==TRUE){
      stop(paste0("ERROR: The treatment indicator ", trt, " is a factor. It has to be numeric"))
    }
    if (is.character(train[[trt]])==TRUE){
      stop(paste0("ERROR: The treatment indicator ", trt, " is a character variable. It has to be numeric"))
    }
    if (!(sort(unique(train[[y]] %in% c(0,1))))){
      stop(paste0("ERROR: the treatment indicator has to be binary"))
    }
    if (any(is.na(train[[trt]]))){
      stop(paste0("ERROR: The treatment indicator ", trt, " has NAs in the input training data frame"))        
    } 
    if (crossval==TRUE){
      if (any(is.na(valid[[trt]]))){
        stop(paste0("ERROR: The treatment indicator ", trt, " has NAs in the input validation data frame"))        
      }
    }
  }  
}
