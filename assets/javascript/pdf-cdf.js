// parse a spec and create a visualization view
function parse(spec, divname) {
  vg.parse.spec(spec, function(chart) { chart({el: divname.toString(), renderer:'svg'}).update(); });
}

parse("../assets/ruby/Project1/json-1/chang-pdf.json","#pdf-chang");
parse("../assets/ruby/Project1/json-1/crowd-pdf.json","#pdf-crowd");
parse("../assets/ruby/Project1/json-1/portal-pdf.json","#pdf-portal");
parse("../assets/ruby/Project1/json-1/university-pdf.json","#pdf-university");
parse("../assets/ruby/Project1/json-1/notebook-pdf.json","#pdf-notebook");
parse("../assets/ruby/Project1/json-1/baby-pdf.json","#pdf-baby");

parse("../assets/ruby/Project1/json-1/chang-cdf.json","#cdf-chang");
parse("../assets/ruby/Project1/json-1/crowd-cdf.json","#cdf-crowd");
parse("../assets/ruby/Project1/json-1/portal-cdf.json","#cdf-portal");
parse("../assets/ruby/Project1/json-1/university-cdf.json","#cdf-university");
parse("../assets/ruby/Project1/json-1/notebook-cdf.json","#cdf-notebook");
parse("../assets/ruby/Project1/json-1/baby-cdf.json","#cdf-baby");

parse("../assets/ruby/Project1/json-2/chang-pdf-cdf.json","#pdf-cdf-chang");
parse("../assets/ruby/Project1/json-2/crowd-pdf-cdf.json","#pdf-cdf-crowd");
parse("../assets/ruby/Project1/json-2/portal-pdf-cdf.json","#pdf-cdf-portal");
parse("../assets/ruby/Project1/json-2/university-pdf-cdf.json","#pdf-cdf-university");
parse("../assets/ruby/Project1/json-2/notebook-pdf-cdf.json","#pdf-cdf-notebook");
parse("../assets/ruby/Project1/json-2/baby-pdf-cdf.json","#pdf-cdf-baby");

parse("../assets/ruby/Project1/json-2/chang-pdf-cdf-eq.json","#pdf-cdf-chang-eq");
parse("../assets/ruby/Project1/json-2/crowd-pdf-cdf-eq.json","#pdf-cdf-crowd-eq");
parse("../assets/ruby/Project1/json-2/portal-pdf-cdf-eq.json","#pdf-cdf-portal-eq");
parse("../assets/ruby/Project1/json-2/university-pdf-cdf-eq.json","#pdf-cdf-university-eq");
parse("../assets/ruby/Project1/json-2/notebook-pdf-cdf-eq.json","#pdf-cdf-notebook-eq");
parse("../assets/ruby/Project1/json-2/baby-pdf-cdf-eq.json","#pdf-cdf-baby-eq");


parse("../assets/ruby/Project1/json-3/checker1-pdf.json","#pdf-checker1");
parse("../assets/ruby/Project1/json-3/checker2-pdf.json","#pdf-checker2");

parse("../assets/ruby/Project1/json-3/checker1-class-specific.json","#combined-checker1");
parse("../assets/ruby/Project1/json-3/checker2-class-specific.json","#combined-checker2");

parse("../assets/ruby/Project1/json-3/checker1-final.json","#final-checker1");
parse("../assets/ruby/Project1/json-3/checker2-final.json","#final-checker2");

parse("../assets/ruby/Project1/json-3/checker1-final-bumped.json","#final-bumped-checker1");
parse("../assets/ruby/Project1/json-3/checker2-final-bumped.json","#final-bumped-checker2");

parse("../assets/ruby/Project1/json-3/CTscan-hist.json","#hist-ct");
parse("../assets/ruby/Project1/json-3/CTscan-cdf.json","#cdf-ct");
parse("../assets/ruby/Project1/json-3/CTscan-final.json","#final-ct");
