# install renv if it doesn't exist on your system
if(!"renv" %in% installed.packages()[, "Package"]) install.packages("renv")
# Remove bare = TRUE if you'd like to move your existing packages over to
# renv. This is not a good idea if you're migrating from s3tools as
# renv will attempt to install that library.
renv::init(bare = TRUE)
# Tell renv to use Python and set up a virtual environment
# if you get an error here, remove the python path argument and
# manually select the version of python you require
renv::use_python(python='/usr/bin/python3')
# Install reticulate so we can make calls to Python libraries, required by
# botor
renv::install('reticulate')
# Install the Python library, boto3, used by botor to access S3
reticulate::py_install('boto3')
# Install botor itself
renv::install('botor')

renv::install("git@github.com:moj-analytical-services/xltabr.git")
renv::install("git@github.com:moj-analytical-services/mojtable.git")