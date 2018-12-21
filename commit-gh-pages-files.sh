hugo -D
echo insecure.ucdavis.edu >> CNAME
cd public && git add --all && git commit -m "Publishing to gh-pages" && cd ..
