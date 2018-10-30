# gdalwarp
		Image reprojection and warping utility


## Examples

- Change the source projection system [-s_srs] to target projection [-t_srs]
- Further, the target file will be overwritten if it exist [-overwrite].

	gdalwarp -overwrite -s_srs {{source_proj}} -t_srs {{target_proj}} {{source_file}} {{output_file}}

{{proj}} definition can be EPSG PCS or GCS (like EPSG:4326) or PROJ.4
(like '+proj=utm +zone=11 +datum=WGS84') or name of a .prj file.
For running the above code in parallel add [-wo NUM_THREADS={{value}}] or
[-wo NUM_THREADS=ALL_CPUS]


- Specify nodata values in source [-srcnodata] and/or target [-dstnodata]

	gdalwarp -srcnodata {{value}} -dstnodata {{value}} {{source_file}} {{output_file}}


- Mask the output raster by polygon shape feature [-cutline] and crop it also [-crop_to_cutline]

	gdalwarp -cutline {{polygon_shape_file}} -crop_to_cutline {{source_file}} {{output_file}}


- Resample the raster image [-r] and change resolution [-tr]

	gdalwarp -r {{resample_method}} -tr {{xres}} {{yres}} {{source_file}} {{output_file}}


{{resample_method}} can be nearest[near], bilinear, cubic, cubicspline,
lanczos, average, maximum[max], minimum[min], first quartile[q1],
third quartile[q3] etc. Further, {{xres}} and {{yres}} are in target projection system.


- Set geographical extent[-te] of the output file

	gdalwarp -te {{xmin}} {{ymin}} {{xmax}} {{ymax}} {{source_file}} {{output_file}}


