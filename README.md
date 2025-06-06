Experimenting with containers to get the patter [R package](https://github.com/edwardlavender/patter) (and [Julia friends](https://github.com/edwardlavender/patter.jl)) up and running with as little pain as possible.

- Dockerfile-test is Ubuntu noble with Julia 1.11.5 and R 4.5.0 installed via r2u. 2.07GB
  - `docker pull ghcr.io/mhpob/patter:test` or
  - `docker build -f Dockerfile-test -t patter:test .`
- Dockerfile is the same, but also has Patter.jl and dependencies installed (via Julia), as well as the patter R package and dependencies. Julia has already been connected to R via `JuliaCall::julia_setup()`. 3.18GB
  - `docker pull ghcr.io/mhpob/patter:ubuntu` or
  - `docker build -f Dockerfile -t patter:ubuntu .`
- Dockerfile-alpine is a failed attempt at creating a light Alpine Linux container. This seems to be dead as Alpine doesn't have libmpi.so.12, needed by HDF5_jll.
  - See https://github.com/edwardlavender/Patter.jl/issues/2
  - `docker build -f Dockerfile-alpine -t patter:alpine .`
 
- Containers are here: https://github.com/users/mhpob/packages/container/package/patter
