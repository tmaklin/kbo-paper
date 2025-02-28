# kbo paper sources

## Files
- `experiments`: files used to generate the use cases and figures.
- `paper`: manuscript files.

## Running the experiments
Use docker to reproduce the results used in the manuscript by running

```sh
## Build the image
docker build -t kbo_paper experiments

## Run
docker run -t kbo_paper
```
