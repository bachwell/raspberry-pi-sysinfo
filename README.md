# RaspiSysinfo

## vcgencmd

> __`vcgencmd: /usr/bin/vcgencmd`__

> __`vcgencmd version`__

> __`vcgencmd commands`__
```
vcos, ap_output_control, ap_output_post_processing, vchi_test_init, vchi_test_exit, vctest_memmap, vctest_start, vctest_stop, vctest_set, vctest_get, pm_set_policy, pm_get_status, pm_show_stats, pm_start_logging, pm_stop_logging, version, commands, set_vll_dir, set_backlight, set_logging, get_lcd_info, arbiter, cache_flush, otp_dump, test_result, codec_enabled, get_camera, get_mem, measure_clock, measure_volts, scaling_kernel, scaling_sharpness, get_hvs_asserts, get_throttled, measure_temp, get_config, hdmi_ntsc_freqs, hdmi_adjust_clock, hdmi_status_show, hvs_update_fields, pwm_speedup, force_audio, hdmi_stream_channels, hdmi_channel_map, display_power, read_ring_osc, memtest, dispmanx_list, get_rsts, schmoo, render_bar, disk_notify, inuse_notify, sus_suspend, sus_status, sus_is_enabled, sus_stop_test_thread, egl_platform_switch, mem_validate, mem_oom, mem_reloc_stats, hdmi_cvt, hdmi_timings, file
```

> __`vcgencmd measure_clock <clock>`__
```
clock: arm, core, h264, isp, v3d, uart, pwm, emmc, pixel, vec, hdmi, dpi.
```

> __`vcgencmd measure_volts <id>`__
```
id: core, sdram_c, sdram_i, sdram_p
```

> __`vcgencmd measure_temp`__


> __`vcgencmd codec_enabled <codec>`__
```
codec: H263, H264, MPG2, WVC1, MPG4, AGIF, MJPA, MJPB, MJPG, WMV9, MVC0
```

> __`vcgencmd get_config [config|int|str]`__

> __`vcgencmd get_mem arm/gpu`__

> __`vcgencmd version`__

> __`vcgencmd otp_dump`__

> __`vcgencmd get_lcd_info`__
```
Returns height, width, and depth of the display framebuffer
```


## Copy to Raspberry PI

> `rsync -avz --exclude='.git' --exclude='.build' --exclude='*.xcodeproj' -e ssh <path_to_roo_folder_of_project> <pi_user>@0.0.0.0:<path_to_roo_folder_of_project>`

