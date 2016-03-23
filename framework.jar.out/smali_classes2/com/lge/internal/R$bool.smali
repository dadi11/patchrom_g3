.class public final Lcom/lge/internal/R$bool;
.super Ljava/lang/Object;
.source "R.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/lge/internal/R;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = "bool"
.end annotation


# static fields
.field public static action_bar_embed_tabs:I

.field public static action_bar_expanded_action_views_exclusive:I

.field public static config_LGInputEventListener_available:I

.field public static config_LedOnEvenWhenLcdOn:I

.field public static config_audio_soundprofile:I

.field public static config_audio_visualvoice:I

.field public static config_capp_touch_flick_noti_available:I

.field public static config_chameleon_supported:I

.field public static config_chameleon_sysprop_carrierid_enabled:I

.field public static config_cliptray_available:I

.field public static config_cliptray_lock_delete_available:I

.field public static config_data_encrypt:I

.field public static config_dfps_available:I

.field public static config_dgpc_available:I

.field public static config_disable_number_keypad:I

.field public static config_double_tap_wakeup_mode:I

.field public static config_editor_reverse_handle_available:I

.field public static config_emergency_launcher_available:I

.field public static config_enable_chromecast_mirroring:I

.field public static config_enable_exceptionalLed:I

.field public static config_enable_fake_battery_temp:I

.field public static config_enable_transit_duration:I

.field public static config_enable_volume_changeLed:I

.field public static config_enable_wireless_charging:I

.field public static config_fast_current_consume:I

.field public static config_fixed_wallpaper_available_in_Gallery:I

.field public static config_focus_during_call_enabled:I

.field public static config_fonts:I

.field public static config_fourth_key_sharing_available:I

.field public static config_front_menu_or_recent_key:I

.field public static config_goto_calllog_by_headsethook:I

.field public static config_haptic_feedback_avaiable:I

.field public static config_hasBackLed:I

.field public static config_hasColorBackLed:I

.field public static config_hasOneColorLed:I

.field public static config_hold_call_by_powerkey:I

.field public static config_home_key_exception_in_ecm_mode:I

.field public static config_invert_color_support:I

.field public static config_is_using_embedded_battery:I

.field public static config_is_using_embedded_battery_with_cover:I

.field public static config_kidsmode_available:I

.field public static config_knock_off_available:I

.field public static config_knockon_available:I

.field public static config_lcd_auto_brightness_mode:I

.field public static config_lcd_oled:I

.field public static config_lg_safe_media_volume_enabled:I

.field public static config_lge_safe_media_volume_enabled:I

.field public static config_lowpassfilter_disable:I

.field public static config_lpwg_by_knockonproximity:I

.field public static config_lpwg_by_lightsensor:I

.field public static config_menu_long_available:I

.field public static config_moving_system_bar:I

.field public static config_msim_dsda:I

.field public static config_multiuser_knockcode:I

.field public static config_notify_pdk_status:I

.field public static config_off_power_long_available:I

.field public static config_powerLight_available:I

.field public static config_power_key_screen_on_in_calling:I

.field public static config_power_restart_action_available:I

.field public static config_power_volumedown_reset:I

.field public static config_power_volumue_key_in_calling:I

.field public static config_power_wakelock_detector:I

.field public static config_private_log_disable:I

.field public static config_providePreviewPattern:I

.field public static config_proximity_sleep_available:I

.field public static config_quick_memo_hotkey_customizing:I

.field public static config_quick_memo_hotkey_long_enable:I

.field public static config_quickmemo_by_volumekey:I

.field public static config_rearside_key:I

.field public static config_recent_long_available:I

.field public static config_rotated_knockcode:I

.field public static config_screenOffAni:I

.field public static config_sd_encrypt:I

.field public static config_sdcard_encryption_available:I

.field public static config_security_knockon:I

.field public static config_shaking_gesture:I

.field public static config_shutdown_soc_zero:I

.field public static config_sim_switch_key_available:I

.field public static config_smart_battery:I

.field public static config_smart_cover:I

.field public static config_support_abs:I

.field public static config_support_shutdown_animation_landscape:I

.field public static config_support_touch_event_filter:I

.field public static config_support_verizonavs:I

.field public static config_systemui_feature_allow_vertical_translucent_navigation_bar:I

.field public static config_systemui_feature_mini_music_control:I

.field public static config_touch_drum_effect_available:I

.field public static config_touch_slop_separation_available:I

.field public static config_touchscreen_turn_on_button_light:I

.field public static config_useLedAutoBrightness:I

.field public static config_use_hasPermanentMenuKey:I

.field public static config_use_mabl:I

.field public static config_use_rndisdriver:I

.field public static config_use_screen_auto_brightness_adjustment:I

.field public static config_use_smart_ringtone:I

.field public static config_userConfigLedBrightness:I

.field public static config_using_circle_cover:I

.field public static config_using_lollipop_cover:I

.field public static config_using_slide_cover:I

.field public static config_using_smart_cover:I

.field public static config_using_window_cover:I

.field public static config_vol_up_toast_enabled:I

.field public static config_volumeKeyLongPress:I

.field public static config_volume_down_turn_on_screen:I

.field public static config_wlan_supportsimaka:I

.field public static dock_service_enabled:I

.field public static enable_go_home_from_setupwizard:I

.field public static no_lockscreen_in_setupwizard:I

.field public static preferences_prefer_dual_pane:I

.field public static show_ongoing_ime_switcher:I

.field public static split_action_bar_is_narrow:I

.field public static support_smart_video:I

.field public static support_smartpouch:I

.field public static support_wisescreen:I

.field public static target_honeycomb_needs_options_menu:I


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 81
    const/high16 v0, 0x60000

    sput v0, Lcom/lge/internal/R$bool;->action_bar_embed_tabs:I

    .line 82
    const v0, 0x60004

    sput v0, Lcom/lge/internal/R$bool;->action_bar_expanded_action_views_exclusive:I

    .line 86
    const v0, 0x6006b

    sput v0, Lcom/lge/internal/R$bool;->config_LGInputEventListener_available:I

    .line 89
    const v0, 0x6005f

    sput v0, Lcom/lge/internal/R$bool;->config_LedOnEvenWhenLcdOn:I

    .line 90
    const v0, 0x60024

    sput v0, Lcom/lge/internal/R$bool;->config_audio_soundprofile:I

    .line 91
    const v0, 0x60025

    sput v0, Lcom/lge/internal/R$bool;->config_audio_visualvoice:I

    .line 95
    const v0, 0x60058

    sput v0, Lcom/lge/internal/R$bool;->config_capp_touch_flick_noti_available:I

    .line 99
    const v0, 0x60027

    sput v0, Lcom/lge/internal/R$bool;->config_chameleon_supported:I

    .line 102
    const v0, 0x60035

    sput v0, Lcom/lge/internal/R$bool;->config_chameleon_sysprop_carrierid_enabled:I

    .line 106
    const v0, 0x6002b

    sput v0, Lcom/lge/internal/R$bool;->config_cliptray_available:I

    .line 109
    const v0, 0x6002d

    sput v0, Lcom/lge/internal/R$bool;->config_cliptray_lock_delete_available:I

    .line 112
    const v0, 0x60037

    sput v0, Lcom/lge/internal/R$bool;->config_data_encrypt:I

    .line 116
    const v0, 0x60040

    sput v0, Lcom/lge/internal/R$bool;->config_dfps_available:I

    .line 119
    const v0, 0x60043

    sput v0, Lcom/lge/internal/R$bool;->config_dgpc_available:I

    .line 122
    const v0, 0x60045

    sput v0, Lcom/lge/internal/R$bool;->config_disable_number_keypad:I

    .line 128
    const v0, 0x60064

    sput v0, Lcom/lge/internal/R$bool;->config_double_tap_wakeup_mode:I

    .line 132
    const v0, 0x6002a

    sput v0, Lcom/lge/internal/R$bool;->config_editor_reverse_handle_available:I

    .line 136
    const v0, 0x60052

    sput v0, Lcom/lge/internal/R$bool;->config_emergency_launcher_available:I

    .line 140
    const v0, 0x6003a

    sput v0, Lcom/lge/internal/R$bool;->config_enable_chromecast_mirroring:I

    .line 144
    const v0, 0x60063

    sput v0, Lcom/lge/internal/R$bool;->config_enable_exceptionalLed:I

    .line 148
    const v0, 0x60077

    sput v0, Lcom/lge/internal/R$bool;->config_enable_fake_battery_temp:I

    .line 151
    const v0, 0x6003f

    sput v0, Lcom/lge/internal/R$bool;->config_enable_transit_duration:I

    .line 154
    const v0, 0x60062

    sput v0, Lcom/lge/internal/R$bool;->config_enable_volume_changeLed:I

    .line 157
    const v0, 0x60073

    sput v0, Lcom/lge/internal/R$bool;->config_enable_wireless_charging:I

    .line 161
    const v0, 0x60076

    sput v0, Lcom/lge/internal/R$bool;->config_fast_current_consume:I

    .line 162
    const v0, 0x6000d

    sput v0, Lcom/lge/internal/R$bool;->config_fixed_wallpaper_available_in_Gallery:I

    .line 166
    const v0, 0x60013

    sput v0, Lcom/lge/internal/R$bool;->config_focus_during_call_enabled:I

    .line 167
    const v0, 0x6001f

    sput v0, Lcom/lge/internal/R$bool;->config_fonts:I

    .line 171
    const v0, 0x60047

    sput v0, Lcom/lge/internal/R$bool;->config_fourth_key_sharing_available:I

    .line 176
    const v0, 0x6005d

    sput v0, Lcom/lge/internal/R$bool;->config_front_menu_or_recent_key:I

    .line 180
    const v0, 0x60012

    sput v0, Lcom/lge/internal/R$bool;->config_goto_calllog_by_headsethook:I

    .line 181
    const v0, 0x6001b

    sput v0, Lcom/lge/internal/R$bool;->config_haptic_feedback_avaiable:I

    .line 185
    const v0, 0x60030

    sput v0, Lcom/lge/internal/R$bool;->config_hasBackLed:I

    .line 189
    const v0, 0x60031

    sput v0, Lcom/lge/internal/R$bool;->config_hasColorBackLed:I

    .line 193
    const v0, 0x6005b

    sput v0, Lcom/lge/internal/R$bool;->config_hasOneColorLed:I

    .line 196
    const v0, 0x60071

    sput v0, Lcom/lge/internal/R$bool;->config_hold_call_by_powerkey:I

    .line 199
    const v0, 0x6004e

    sput v0, Lcom/lge/internal/R$bool;->config_home_key_exception_in_ecm_mode:I

    .line 204
    const v0, 0x6001a

    sput v0, Lcom/lge/internal/R$bool;->config_invert_color_support:I

    .line 209
    const v0, 0x60021

    sput v0, Lcom/lge/internal/R$bool;->config_is_using_embedded_battery:I

    .line 213
    const v0, 0x60070

    sput v0, Lcom/lge/internal/R$bool;->config_is_using_embedded_battery_with_cover:I

    .line 217
    const v0, 0x60039

    sput v0, Lcom/lge/internal/R$bool;->config_kidsmode_available:I

    .line 221
    const v0, 0x60042

    sput v0, Lcom/lge/internal/R$bool;->config_knock_off_available:I

    .line 226
    const v0, 0x60041

    sput v0, Lcom/lge/internal/R$bool;->config_knockon_available:I

    .line 227
    const v0, 0x60023

    sput v0, Lcom/lge/internal/R$bool;->config_lcd_auto_brightness_mode:I

    .line 231
    const v0, 0x60036

    sput v0, Lcom/lge/internal/R$bool;->config_lcd_oled:I

    .line 235
    const v0, 0x60010

    sput v0, Lcom/lge/internal/R$bool;->config_lg_safe_media_volume_enabled:I

    .line 238
    const v0, 0x60018

    sput v0, Lcom/lge/internal/R$bool;->config_lge_safe_media_volume_enabled:I

    .line 245
    const v0, 0x6006e

    sput v0, Lcom/lge/internal/R$bool;->config_lowpassfilter_disable:I

    .line 249
    const v0, 0x60069

    sput v0, Lcom/lge/internal/R$bool;->config_lpwg_by_knockonproximity:I

    .line 252
    const v0, 0x6006a

    sput v0, Lcom/lge/internal/R$bool;->config_lpwg_by_lightsensor:I

    .line 256
    const v0, 0x6004f

    sput v0, Lcom/lge/internal/R$bool;->config_menu_long_available:I

    .line 259
    const v0, 0x6001d

    sput v0, Lcom/lge/internal/R$bool;->config_moving_system_bar:I

    .line 265
    const v0, 0x60028

    sput v0, Lcom/lge/internal/R$bool;->config_msim_dsda:I

    .line 269
    const v0, 0x60068

    sput v0, Lcom/lge/internal/R$bool;->config_multiuser_knockcode:I

    .line 272
    const v0, 0x6003c

    sput v0, Lcom/lge/internal/R$bool;->config_notify_pdk_status:I

    .line 276
    const v0, 0x60046

    sput v0, Lcom/lge/internal/R$bool;->config_off_power_long_available:I

    .line 282
    const v0, 0x6000b

    sput v0, Lcom/lge/internal/R$bool;->config_powerLight_available:I

    .line 285
    const v0, 0x60054

    sput v0, Lcom/lge/internal/R$bool;->config_power_key_screen_on_in_calling:I

    .line 290
    const v0, 0x60049

    sput v0, Lcom/lge/internal/R$bool;->config_power_restart_action_available:I

    .line 293
    const v0, 0x6006f

    sput v0, Lcom/lge/internal/R$bool;->config_power_volumedown_reset:I

    .line 296
    const v0, 0x60053

    sput v0, Lcom/lge/internal/R$bool;->config_power_volumue_key_in_calling:I

    .line 300
    const v0, 0x6007a

    sput v0, Lcom/lge/internal/R$bool;->config_power_wakelock_detector:I

    .line 303
    const v0, 0x6003d

    sput v0, Lcom/lge/internal/R$bool;->config_private_log_disable:I

    .line 306
    const v0, 0x60061

    sput v0, Lcom/lge/internal/R$bool;->config_providePreviewPattern:I

    .line 312
    const v0, 0x60055

    sput v0, Lcom/lge/internal/R$bool;->config_proximity_sleep_available:I

    .line 317
    const v0, 0x6001c

    sput v0, Lcom/lge/internal/R$bool;->config_quick_memo_hotkey_customizing:I

    .line 321
    const v0, 0x6004d

    sput v0, Lcom/lge/internal/R$bool;->config_quick_memo_hotkey_long_enable:I

    .line 322
    const v0, 0x6004c

    sput v0, Lcom/lge/internal/R$bool;->config_quickmemo_by_volumekey:I

    .line 328
    const v0, 0x6002c

    sput v0, Lcom/lge/internal/R$bool;->config_rearside_key:I

    .line 332
    const v0, 0x60050

    sput v0, Lcom/lge/internal/R$bool;->config_recent_long_available:I

    .line 335
    const v0, 0x60066

    sput v0, Lcom/lge/internal/R$bool;->config_rotated_knockcode:I

    .line 339
    const v0, 0x6000f

    sput v0, Lcom/lge/internal/R$bool;->config_screenOffAni:I

    .line 342
    const v0, 0x60038

    sput v0, Lcom/lge/internal/R$bool;->config_sd_encrypt:I

    .line 345
    const v0, 0x6000c

    sput v0, Lcom/lge/internal/R$bool;->config_sdcard_encryption_available:I

    .line 349
    const v0, 0x60065

    sput v0, Lcom/lge/internal/R$bool;->config_security_knockon:I

    .line 353
    const v0, 0x60051

    sput v0, Lcom/lge/internal/R$bool;->config_shaking_gesture:I

    .line 357
    const v0, 0x60072

    sput v0, Lcom/lge/internal/R$bool;->config_shutdown_soc_zero:I

    .line 362
    const v0, 0x60048

    sput v0, Lcom/lge/internal/R$bool;->config_sim_switch_key_available:I

    .line 366
    const v0, 0x60067

    sput v0, Lcom/lge/internal/R$bool;->config_smart_battery:I

    .line 371
    const v0, 0x60014

    sput v0, Lcom/lge/internal/R$bool;->config_smart_cover:I

    .line 375
    const v0, 0x60078

    sput v0, Lcom/lge/internal/R$bool;->config_support_abs:I

    .line 378
    const v0, 0x60075

    sput v0, Lcom/lge/internal/R$bool;->config_support_shutdown_animation_landscape:I

    .line 384
    const v0, 0x60059

    sput v0, Lcom/lge/internal/R$bool;->config_support_touch_event_filter:I

    .line 387
    const v0, 0x60034

    sput v0, Lcom/lge/internal/R$bool;->config_support_verizonavs:I

    .line 390
    const v0, 0x6000a

    sput v0, Lcom/lge/internal/R$bool;->config_systemui_feature_allow_vertical_translucent_navigation_bar:I

    .line 391
    const v0, 0x60009

    sput v0, Lcom/lge/internal/R$bool;->config_systemui_feature_mini_music_control:I

    .line 395
    const v0, 0x6005c

    sput v0, Lcom/lge/internal/R$bool;->config_touch_drum_effect_available:I

    .line 399
    const v0, 0x6005a

    sput v0, Lcom/lge/internal/R$bool;->config_touch_slop_separation_available:I

    .line 403
    const v0, 0x6005e

    sput v0, Lcom/lge/internal/R$bool;->config_touchscreen_turn_on_button_light:I

    .line 407
    const v0, 0x60060

    sput v0, Lcom/lge/internal/R$bool;->config_useLedAutoBrightness:I

    .line 410
    const v0, 0x60029

    sput v0, Lcom/lge/internal/R$bool;->config_use_hasPermanentMenuKey:I

    .line 413
    const v0, 0x60019

    sput v0, Lcom/lge/internal/R$bool;->config_use_mabl:I

    .line 417
    const v0, 0x60026

    sput v0, Lcom/lge/internal/R$bool;->config_use_rndisdriver:I

    .line 420
    const v0, 0x60079

    sput v0, Lcom/lge/internal/R$bool;->config_use_screen_auto_brightness_adjustment:I

    .line 424
    const v0, 0x60033

    sput v0, Lcom/lge/internal/R$bool;->config_use_smart_ringtone:I

    .line 429
    const v0, 0x6002f

    sput v0, Lcom/lge/internal/R$bool;->config_userConfigLedBrightness:I

    .line 435
    const v0, 0x60057

    sput v0, Lcom/lge/internal/R$bool;->config_using_circle_cover:I

    .line 440
    const v0, 0x60016

    sput v0, Lcom/lge/internal/R$bool;->config_using_lollipop_cover:I

    .line 443
    const v0, 0x6006d

    sput v0, Lcom/lge/internal/R$bool;->config_using_slide_cover:I

    .line 448
    const v0, 0x60015

    sput v0, Lcom/lge/internal/R$bool;->config_using_smart_cover:I

    .line 453
    const v0, 0x60017

    sput v0, Lcom/lge/internal/R$bool;->config_using_window_cover:I

    .line 457
    const v0, 0x60011

    sput v0, Lcom/lge/internal/R$bool;->config_vol_up_toast_enabled:I

    .line 462
    const v0, 0x6004a

    sput v0, Lcom/lge/internal/R$bool;->config_volumeKeyLongPress:I

    .line 465
    const v0, 0x6004b

    sput v0, Lcom/lge/internal/R$bool;->config_volume_down_turn_on_screen:I

    .line 466
    const v0, 0x6001e

    sput v0, Lcom/lge/internal/R$bool;->config_wlan_supportsimaka:I

    .line 467
    const v0, 0x60006

    sput v0, Lcom/lge/internal/R$bool;->dock_service_enabled:I

    .line 470
    const v0, 0x60007

    sput v0, Lcom/lge/internal/R$bool;->enable_go_home_from_setupwizard:I

    .line 471
    const v0, 0x60008

    sput v0, Lcom/lge/internal/R$bool;->no_lockscreen_in_setupwizard:I

    .line 472
    const v0, 0x60002

    sput v0, Lcom/lge/internal/R$bool;->preferences_prefer_dual_pane:I

    .line 473
    const v0, 0x60003

    sput v0, Lcom/lge/internal/R$bool;->show_ongoing_ime_switcher:I

    .line 474
    const v0, 0x60001

    sput v0, Lcom/lge/internal/R$bool;->split_action_bar_is_narrow:I

    .line 475
    const v0, 0x6000e

    sput v0, Lcom/lge/internal/R$bool;->support_smart_video:I

    .line 481
    const v0, 0x60020

    sput v0, Lcom/lge/internal/R$bool;->support_smartpouch:I

    .line 487
    const v0, 0x60022

    sput v0, Lcom/lge/internal/R$bool;->support_wisescreen:I

    .line 488
    const v0, 0x60005

    sput v0, Lcom/lge/internal/R$bool;->target_honeycomb_needs_options_menu:I

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .prologue
    .line 80
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method
