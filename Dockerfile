FROM ubuntu:noble

WORKDIR /home/root

# install Julia
RUN  apt update -qq && apt install --yes --no-install-recommends wget ca-certificates \
  && wget https://julialang-s3.julialang.org/bin/linux/x64/1.11/julia-1.11.5-linux-x86_64.tar.gz \
  && tar zxvf julia-1.11.5-linux-x86_64.tar.gz \
  && rm julia-1.11.5-linux-x86_64.tar.gz

ENV PATH="$PATH:/home/root/julia-1.11.5/bin"

# install patter.jl
RUN julia -e 'using Pkg; Pkg.add(url = "https://github.com/edwardlavender/Patter.jl")'

# install r2u and RCall
# RCall needs to be installed after R or it will install its own version of R
RUN wget https://raw.githubusercontent.com/eddelbuettel/r2u/refs/heads/master/inst/scripts/add_cranapt_noble.sh \
  && chmod +x add_cranapt_noble.sh \
  && ./add_cranapt_noble.sh \
  && rm add_cranapt_noble.sh

# libquadmath needed for RCall/JuliaCall::julia_setup()
RUN apt install --yes --no-install-recommends libquadmath0 \
  && julia -e 'using Pkg; Pkg.add("RCall")'

RUN Rscript -e \
    "install.packages('remotes'); \
      remotes::install_github('edwardlavender/patter', dependencies = TRUE); \
      JuliaCall::julia_setup()"

CMD [ "R" ]
