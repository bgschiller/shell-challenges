# Holey Polygons

There are a number of geojson files representing buildings at https://github.com/microsoft/USBuildingFootprints

We need to know whether these geojson polygons include holes. A polygon in geojson is represented by a list of rings (lists of coordinate pairs). The first ring is always the exterior. Subsequent rings, if there are any, represent holes removing area from the outer ring.

```js
{
  type: "Polygon",
  coordinates: [
    // ring 1, the exterior
    [ [ -120, 60 ], [ 120, 60 ], [ 120, -60 ], [ -120, -60 ], [ -120, 60 ] ],
    // ring 2, the hole
    [ [ -60, 30 ], [ 60, 30 ], [ 60, -30 ], [ -60, -30 ], [ -60, 30 ] ]
  ],
}
```

So the problem of deciding "Does this polygon have a hole?" can be simplified to "Does the geojson for this polygon have more than one ring?"

Let's do a couple warm-ups first to get familiar with the tool we'll be using: `jq`.

### Warm-up 1: How many polygons?

Using `jq`, find the total number of polygons in one of the files. You can check your work

####
## answer:

```bash
< Colorado.geojson jq '.features | map(select((.geometry.coordinates | length) > 1))'
```