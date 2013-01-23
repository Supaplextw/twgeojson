<- $ document .ready

cc=1
svg = d3.select \#map
layer = svg.append \g .attr \id \layer
states = layer.append \g \id \states .selectAll \path
proj = d3.geo.mercator!.scale 50000 .translate [-16500, 3650]
carto = d3.cartogram!.projection proj .value -> Math.random! * 100

d3.json \twCounty1982.topojson, (topo) ->
  geometries = topo.objects.twCounty1982.geometries
  features = carto.features topo, geometries
  path = d3.geo.path!.projection proj
  states := states.data features .enter! .append \path
    .attr \class \state
    .attr \fill \#fafafa
    .attr \stroke-width \1px
    .attr \stroke \#999
    .attr \d path 
  features = carto topo, geometries .features
  states.data(features)
  states.transition! .duration 1000 .attr \d carto.path
    #.attr \transform "translate(-2000 -400) scale(20)"