hugo -D
cd public
echo insecure.ucdavis.edu >> CNAME
git add --all && git commit -m "Publishing to gh-pages" && cd ..
