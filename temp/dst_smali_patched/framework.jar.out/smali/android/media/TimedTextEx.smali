.class public Landroid/media/TimedTextEx;
.super Ljava/lang/Object;
.source "TimedTextEx.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Landroid/media/TimedTextEx$FormFeed;,
        Landroid/media/TimedTextEx$HorizontalCarriageReturn;,
        Landroid/media/TimedTextEx$Reset;,
        Landroid/media/TimedTextEx$DelayCancel;,
        Landroid/media/TimedTextEx$Delay;,
        Landroid/media/TimedTextEx$SetPenLocation;,
        Landroid/media/TimedTextEx$SetPenColor;,
        Landroid/media/TimedTextEx$SetPenAttribute;,
        Landroid/media/TimedTextEx$SetWindowAttribute;,
        Landroid/media/TimedTextEx$ToggleWindows;,
        Landroid/media/TimedTextEx$HideWindows;,
        Landroid/media/TimedTextEx$DisplayWindows;,
        Landroid/media/TimedTextEx$DeleteWindows;,
        Landroid/media/TimedTextEx$DefineWindow;,
        Landroid/media/TimedTextEx$ClearWindows;,
        Landroid/media/TimedTextEx$SetCurrentWindow;,
        Landroid/media/TimedTextEx$TextAttribute;,
        Landroid/media/TimedTextEx$PreambleAdressCode;,
        Landroid/media/TimedTextEx$ResumeTextDisplay;,
        Landroid/media/TimedTextEx$Backspace;,
        Landroid/media/TimedTextEx$EraseNondisplayMemory;,
        Landroid/media/TimedTextEx$CarriageReturn;,
        Landroid/media/TimedTextEx$Rollup4;,
        Landroid/media/TimedTextEx$Rollup3;,
        Landroid/media/TimedTextEx$Rollup2;,
        Landroid/media/TimedTextEx$TapOffset3;,
        Landroid/media/TimedTextEx$TapOffset2;,
        Landroid/media/TimedTextEx$TapOffset1;,
        Landroid/media/TimedTextEx$EndOfCaption;,
        Landroid/media/TimedTextEx$ResumeCaptionLoading;,
        Landroid/media/TimedTextEx$EraseDisplayMemory;
    }
.end annotation


# static fields
.field private static final FIRST_PRIVATE_KEY:I = 0x12d

.field private static final FIRST_PUBLIC_KEY:I = 0x1

.field public static final KEY_EX_COMMAND:I = 0x6

.field public static final KEY_EX_COMMAND_BACKSPACE:I = 0x70

.field public static final KEY_EX_COMMAND_CARRIAGE_RETURN:I = 0x6e

.field public static final KEY_EX_COMMAND_CLEAR_WINDOWS:I = 0xca

.field public static final KEY_EX_COMMAND_DEFINE_WINDOW:I = 0xcb

.field public static final KEY_EX_COMMAND_DELAY:I = 0xdd

.field public static final KEY_EX_COMMAND_DELAY_CANCEL:I = 0xde

.field public static final KEY_EX_COMMAND_DELETE_WINDOWS:I = 0xcc

.field public static final KEY_EX_COMMAND_DISPLAY_WINDOWS:I = 0xcd

.field public static final KEY_EX_COMMAND_END_OF_CAPTION:I = 0x67

.field public static final KEY_EX_COMMAND_ERASE_DISPLAYED_MEMORY:I = 0x65

.field public static final KEY_EX_COMMAND_ERASE_NONDISPLAYED_MEMORY:I = 0x6f

.field public static final KEY_EX_COMMAND_FORM_FEED:I = 0xe8

.field public static final KEY_EX_COMMAND_HIDE_WINDOWS:I = 0xce

.field public static final KEY_EX_COMMAND_HORIZONTAL_CARRIAGE_RETURN:I = 0xe7

.field public static final KEY_EX_COMMAND_PAC:I = 0x72

.field private static final KEY_EX_COMMAND_PARA_ANCHOR_HORIZONTAL:I = 0x133

.field private static final KEY_EX_COMMAND_PARA_ANCHOR_POINT:I = 0x130

.field private static final KEY_EX_COMMAND_PARA_ANCHOR_VERTICAL:I = 0x132

.field private static final KEY_EX_COMMAND_PARA_BG_COLOR:I = 0x154

.field private static final KEY_EX_COMMAND_PARA_BG_OPACITY:I = 0x155

.field private static final KEY_EX_COMMAND_PARA_BORDER_COLOR:I = 0x145

.field private static final KEY_EX_COMMAND_PARA_BORDER_TYPE:I = 0x144

.field private static final KEY_EX_COMMAND_PARA_COLOR_608:I = 0x16a

.field private static final KEY_EX_COMMAND_PARA_COLUMN:I = 0x158

.field private static final KEY_EX_COMMAND_PARA_COLUMN_COUNT:I = 0x135

.field private static final KEY_EX_COMMAND_PARA_COLUMN_LOCK:I = 0x137

.field private static final KEY_EX_COMMAND_PARA_DISPLAY_EFFECT:I = 0x13f

.field private static final KEY_EX_COMMAND_PARA_EDGE_COLOR:I = 0x156

.field private static final KEY_EX_COMMAND_PARA_EDGE_TYPE:I = 0x151

.field private static final KEY_EX_COMMAND_PARA_EFFECT_DIRECTION:I = 0x140

.field private static final KEY_EX_COMMAND_PARA_EFFECT_SPEED:I = 0x141

.field private static final KEY_EX_COMMAND_PARA_FG_COLOR:I = 0x152

.field private static final KEY_EX_COMMAND_PARA_FG_OPACITY:I = 0x153

.field private static final KEY_EX_COMMAND_PARA_FILL_COLOR:I = 0x142

.field private static final KEY_EX_COMMAND_PARA_FILL_OPACITY:I = 0x143

.field private static final KEY_EX_COMMAND_PARA_FONT:I = 0x14c

.field private static final KEY_EX_COMMAND_PARA_FONT_608:I = 0x16b

.field private static final KEY_EX_COMMAND_PARA_INDENT_608:I = 0x16c

.field private static final KEY_EX_COMMAND_PARA_ITALICS:I = 0x14f

.field private static final KEY_EX_COMMAND_PARA_JUSTIFY:I = 0x13b

.field private static final KEY_EX_COMMAND_PARA_OFFSET:I = 0x14e

.field private static final KEY_EX_COMMAND_PARA_PEN_SIZE:I = 0x14b

.field private static final KEY_EX_COMMAND_PARA_PEN_STYLE_ID:I = 0x13a

.field private static final KEY_EX_COMMAND_PARA_PRINT_DIRECTION:I = 0x13c

.field private static final KEY_EX_COMMAND_PARA_PRIORITY:I = 0x12f

.field private static final KEY_EX_COMMAND_PARA_RELATIVE_POSITION:I = 0x131

.field private static final KEY_EX_COMMAND_PARA_ROW:I = 0x157

.field private static final KEY_EX_COMMAND_PARA_ROW_608:I = 0x169

.field private static final KEY_EX_COMMAND_PARA_ROW_COUNT:I = 0x134

.field private static final KEY_EX_COMMAND_PARA_ROW_LOCK:I = 0x136

.field private static final KEY_EX_COMMAND_PARA_SCROLL_DIRECTION:I = 0x13d

.field private static final KEY_EX_COMMAND_PARA_TENTHS_SECONDS:I = 0x15f

.field private static final KEY_EX_COMMAND_PARA_TEXT_TAG:I = 0x14d

.field private static final KEY_EX_COMMAND_PARA_UNDERLINE:I = 0x150

.field private static final KEY_EX_COMMAND_PARA_VISIBLE:I = 0x138

.field private static final KEY_EX_COMMAND_PARA_WINDOW_ID:I = 0x12d

.field private static final KEY_EX_COMMAND_PARA_WINDOW_MAP:I = 0x12e

.field private static final KEY_EX_COMMAND_PARA_WINDOW_STYLE_ID:I = 0x139

.field private static final KEY_EX_COMMAND_PARA_WORDRAP:I = 0x13e

.field public static final KEY_EX_COMMAND_RESET:I = 0xdf

.field public static final KEY_EX_COMMAND_RESUME_CAPTION_LOADING:I = 0x66

.field public static final KEY_EX_COMMAND_RESUME_TEXT_DISPLAY:I = 0x71

.field public static final KEY_EX_COMMAND_ROLLUP2:I = 0x6b

.field public static final KEY_EX_COMMAND_ROLLUP3:I = 0x6c

.field public static final KEY_EX_COMMAND_ROLLUP4:I = 0x6d

.field public static final KEY_EX_COMMAND_SET_CURRENT_WINDOW:I = 0xc9

.field public static final KEY_EX_COMMAND_SET_PEN_ATTRIBUTE:I = 0xd3

.field public static final KEY_EX_COMMAND_SET_PEN_COLOR:I = 0xd4

.field public static final KEY_EX_COMMAND_SET_PEN_LOCATION:I = 0xd5

.field public static final KEY_EX_COMMAND_SET_WINDOW_ATTRIBUTE:I = 0xd0

.field public static final KEY_EX_COMMAND_TAB_OFFSET1:I = 0x68

.field public static final KEY_EX_COMMAND_TAB_OFFSET2:I = 0x69

.field public static final KEY_EX_COMMAND_TAB_OFFSET3:I = 0x6a

.field public static final KEY_EX_COMMAND_TEXT_ATTR:I = 0x73

.field public static final KEY_EX_COMMAND_TOGGLE_WINDOWS:I = 0xcf

.field public static final KEY_EX_DATA:I = 0xa

.field private static final KEY_EX_GLOBAL_SETTING:I = 0x191

.field public static final KEY_EX_HEIGHT:I = 0x8

.field public static final KEY_EX_LANGUAGE:I = 0x4

.field public static final KEY_EX_LANGUAGE_COUNT:I = 0x3

.field private static final KEY_EX_LOCAL_SETTING:I = 0x192

.field public static final KEY_EX_MAX_SERVICE_NUM:I = 0xc

.field public static final KEY_EX_MEDIA_MIMETYPE:I = 0x1

.field public static final KEY_EX_SERVICE_NUM:I = 0xb

.field public static final KEY_EX_START_TIME_MS:I = 0x2

.field public static final KEY_EX_STRUCT_TEXT_POS:I = 0x7

.field public static final KEY_EX_TEXT:I = 0x5

.field public static final KEY_EX_WIDTH:I = 0x9

.field private static final LAST_PRIVATE_KEY:I = 0x192

.field private static final LAST_PUBLIC_KEY:I = 0xe8

.field private static final SERVICE_COUNT:I = 0x44

.field private static final SERVICE_COUNT_CEA608:I = 0x4

.field private static final SERVICE_COUNT_CEA708:I = 0x40

.field private static final TAG:Ljava/lang/String; = "TimedTextEx"


# instance fields
.field private mBackspace:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList",
            "<",
            "Landroid/media/TimedTextEx$Backspace;",
            ">;"
        }
    .end annotation
.end field

.field private mCR:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList",
            "<",
            "Landroid/media/TimedTextEx$CarriageReturn;",
            ">;"
        }
    .end annotation
.end field

.field private mClearWins:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList",
            "<",
            "Landroid/media/TimedTextEx$ClearWindows;",
            ">;"
        }
    .end annotation
.end field

.field private mData:[B

.field private mDefineWin:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList",
            "<",
            "Landroid/media/TimedTextEx$DefineWindow;",
            ">;"
        }
    .end annotation
.end field

.field private mDelWins:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList",
            "<",
            "Landroid/media/TimedTextEx$DeleteWindows;",
            ">;"
        }
    .end annotation
.end field

.field private mDelay:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList",
            "<",
            "Landroid/media/TimedTextEx$Delay;",
            ">;"
        }
    .end annotation
.end field

.field private mDelayCancel:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList",
            "<",
            "Landroid/media/TimedTextEx$DelayCancel;",
            ">;"
        }
    .end annotation
.end field

.field private mDisplayWins:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList",
            "<",
            "Landroid/media/TimedTextEx$DisplayWindows;",
            ">;"
        }
    .end annotation
.end field

.field private mEndofCaption:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList",
            "<",
            "Landroid/media/TimedTextEx$EndOfCaption;",
            ">;"
        }
    .end annotation
.end field

.field private mEraseDisMem:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList",
            "<",
            "Landroid/media/TimedTextEx$EraseDisplayMemory;",
            ">;"
        }
    .end annotation
.end field

.field private mEraseNonDisMem:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList",
            "<",
            "Landroid/media/TimedTextEx$EraseNondisplayMemory;",
            ">;"
        }
    .end annotation
.end field

.field private mFormFeed:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList",
            "<",
            "Landroid/media/TimedTextEx$FormFeed;",
            ">;"
        }
    .end annotation
.end field

.field private mHeight:I

.field private mHideWins:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList",
            "<",
            "Landroid/media/TimedTextEx$HideWindows;",
            ">;"
        }
    .end annotation
.end field

.field private mHorizontalCarriageReturn:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList",
            "<",
            "Landroid/media/TimedTextEx$HorizontalCarriageReturn;",
            ">;"
        }
    .end annotation
.end field

.field private mIndex:I

.field private final mKeyObjectMap:Ljava/util/HashMap;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/HashMap",
            "<",
            "Ljava/lang/Integer;",
            "Ljava/lang/Object;",
            ">;"
        }
    .end annotation
.end field

.field private mLanguageCount:I

.field private final mLanguageList:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList",
            "<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field private mMimeTypeChars:Ljava/lang/String;

.field private mPreambleAdressCode:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList",
            "<",
            "Landroid/media/TimedTextEx$PreambleAdressCode;",
            ">;"
        }
    .end annotation
.end field

.field private mReset:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList",
            "<",
            "Landroid/media/TimedTextEx$Reset;",
            ">;"
        }
    .end annotation
.end field

.field private mResumeCaption:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList",
            "<",
            "Landroid/media/TimedTextEx$ResumeCaptionLoading;",
            ">;"
        }
    .end annotation
.end field

.field private mResumeTextDis:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList",
            "<",
            "Landroid/media/TimedTextEx$ResumeTextDisplay;",
            ">;"
        }
    .end annotation
.end field

.field private mRollup2:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList",
            "<",
            "Landroid/media/TimedTextEx$Rollup2;",
            ">;"
        }
    .end annotation
.end field

.field private mRollup3:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList",
            "<",
            "Landroid/media/TimedTextEx$Rollup3;",
            ">;"
        }
    .end annotation
.end field

.field private mRollup4:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList",
            "<",
            "Landroid/media/TimedTextEx$Rollup4;",
            ">;"
        }
    .end annotation
.end field

.field private final mServiceNumberList:[I

.field private mServiceNumberMax:I

.field private mSetCurWin:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList",
            "<",
            "Landroid/media/TimedTextEx$SetCurrentWindow;",
            ">;"
        }
    .end annotation
.end field

.field private mSetPenAttribute:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList",
            "<",
            "Landroid/media/TimedTextEx$SetPenAttribute;",
            ">;"
        }
    .end annotation
.end field

.field private mSetPenColor:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList",
            "<",
            "Landroid/media/TimedTextEx$SetPenColor;",
            ">;"
        }
    .end annotation
.end field

.field private mSetPenLocation:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList",
            "<",
            "Landroid/media/TimedTextEx$SetPenLocation;",
            ">;"
        }
    .end annotation
.end field

.field private mSetWinAttribute:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList",
            "<",
            "Landroid/media/TimedTextEx$SetWindowAttribute;",
            ">;"
        }
    .end annotation
.end field

.field private mStartTimeMs:I

.field private mTapOffset1:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList",
            "<",
            "Landroid/media/TimedTextEx$TapOffset1;",
            ">;"
        }
    .end annotation
.end field

.field private mTapOffset2:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList",
            "<",
            "Landroid/media/TimedTextEx$TapOffset2;",
            ">;"
        }
    .end annotation
.end field

.field private mTapOffset3:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList",
            "<",
            "Landroid/media/TimedTextEx$TapOffset3;",
            ">;"
        }
    .end annotation
.end field

.field private mTextAttribute:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList",
            "<",
            "Landroid/media/TimedTextEx$TextAttribute;",
            ">;"
        }
    .end annotation
.end field

.field private mTextBounds:Landroid/graphics/Rect;

.field private final mTextList:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList",
            "<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field private mToggleWins:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList",
            "<",
            "Landroid/media/TimedTextEx$ToggleWindows;",
            ">;"
        }
    .end annotation
.end field

.field private mWidth:I


# direct methods
.method protected constructor <init>(Landroid/os/Parcel;)V
    .locals 4
    .param p1, "parcel"    # Landroid/os/Parcel;

    .prologue
    const/4 v3, 0x0

    const/4 v2, -0x1

    const/4 v1, 0x0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Landroid/media/TimedTextEx;->mLanguageList:Ljava/util/ArrayList;

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Landroid/media/TimedTextEx;->mTextList:Ljava/util/ArrayList;

    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    iput-object v0, p0, Landroid/media/TimedTextEx;->mKeyObjectMap:Ljava/util/HashMap;

    iput v2, p0, Landroid/media/TimedTextEx;->mServiceNumberMax:I

    const/16 v0, 0x44

    new-array v0, v0, [I

    iput-object v0, p0, Landroid/media/TimedTextEx;->mServiceNumberList:[I

    iput-object v1, p0, Landroid/media/TimedTextEx;->mTextBounds:Landroid/graphics/Rect;

    iput v2, p0, Landroid/media/TimedTextEx;->mHeight:I

    iput v2, p0, Landroid/media/TimedTextEx;->mWidth:I

    iput-object v1, p0, Landroid/media/TimedTextEx;->mMimeTypeChars:Ljava/lang/String;

    iput v3, p0, Landroid/media/TimedTextEx;->mStartTimeMs:I

    iput v3, p0, Landroid/media/TimedTextEx;->mLanguageCount:I

    iput v3, p0, Landroid/media/TimedTextEx;->mIndex:I

    iput-object v1, p0, Landroid/media/TimedTextEx;->mEraseDisMem:Ljava/util/ArrayList;

    iput-object v1, p0, Landroid/media/TimedTextEx;->mResumeCaption:Ljava/util/ArrayList;

    iput-object v1, p0, Landroid/media/TimedTextEx;->mEndofCaption:Ljava/util/ArrayList;

    iput-object v1, p0, Landroid/media/TimedTextEx;->mTapOffset1:Ljava/util/ArrayList;

    iput-object v1, p0, Landroid/media/TimedTextEx;->mTapOffset2:Ljava/util/ArrayList;

    iput-object v1, p0, Landroid/media/TimedTextEx;->mTapOffset3:Ljava/util/ArrayList;

    iput-object v1, p0, Landroid/media/TimedTextEx;->mRollup2:Ljava/util/ArrayList;

    iput-object v1, p0, Landroid/media/TimedTextEx;->mRollup3:Ljava/util/ArrayList;

    iput-object v1, p0, Landroid/media/TimedTextEx;->mRollup4:Ljava/util/ArrayList;

    iput-object v1, p0, Landroid/media/TimedTextEx;->mCR:Ljava/util/ArrayList;

    iput-object v1, p0, Landroid/media/TimedTextEx;->mEraseNonDisMem:Ljava/util/ArrayList;

    iput-object v1, p0, Landroid/media/TimedTextEx;->mBackspace:Ljava/util/ArrayList;

    iput-object v1, p0, Landroid/media/TimedTextEx;->mResumeTextDis:Ljava/util/ArrayList;

    iput-object v1, p0, Landroid/media/TimedTextEx;->mPreambleAdressCode:Ljava/util/ArrayList;

    iput-object v1, p0, Landroid/media/TimedTextEx;->mTextAttribute:Ljava/util/ArrayList;

    iput-object v1, p0, Landroid/media/TimedTextEx;->mSetCurWin:Ljava/util/ArrayList;

    iput-object v1, p0, Landroid/media/TimedTextEx;->mClearWins:Ljava/util/ArrayList;

    iput-object v1, p0, Landroid/media/TimedTextEx;->mDefineWin:Ljava/util/ArrayList;

    iput-object v1, p0, Landroid/media/TimedTextEx;->mDelWins:Ljava/util/ArrayList;

    iput-object v1, p0, Landroid/media/TimedTextEx;->mDisplayWins:Ljava/util/ArrayList;

    iput-object v1, p0, Landroid/media/TimedTextEx;->mHideWins:Ljava/util/ArrayList;

    iput-object v1, p0, Landroid/media/TimedTextEx;->mToggleWins:Ljava/util/ArrayList;

    iput-object v1, p0, Landroid/media/TimedTextEx;->mSetWinAttribute:Ljava/util/ArrayList;

    iput-object v1, p0, Landroid/media/TimedTextEx;->mSetPenAttribute:Ljava/util/ArrayList;

    iput-object v1, p0, Landroid/media/TimedTextEx;->mSetPenColor:Ljava/util/ArrayList;

    iput-object v1, p0, Landroid/media/TimedTextEx;->mSetPenLocation:Ljava/util/ArrayList;

    iput-object v1, p0, Landroid/media/TimedTextEx;->mDelay:Ljava/util/ArrayList;

    iput-object v1, p0, Landroid/media/TimedTextEx;->mDelayCancel:Ljava/util/ArrayList;

    iput-object v1, p0, Landroid/media/TimedTextEx;->mReset:Ljava/util/ArrayList;

    iput-object v1, p0, Landroid/media/TimedTextEx;->mHorizontalCarriageReturn:Ljava/util/ArrayList;

    iput-object v1, p0, Landroid/media/TimedTextEx;->mFormFeed:Ljava/util/ArrayList;

    return-void
.end method

.method private containsKey(I)Z
    .locals 2
    .param p1, "key"    # I

    .prologue
    const-string v0, "TimedTextEx"

    const-string v1, "containsKey"

    invoke-static {v0, v1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    invoke-direct {p0, p1}, Landroid/media/TimedTextEx;->isValidKey(I)Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Landroid/media/TimedTextEx;->mKeyObjectMap:Ljava/util/HashMap;

    invoke-static {p1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/util/HashMap;->containsKey(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method private initCommand()V
    .locals 43

    .prologue
    move-object/from16 v0, p0

    iget v5, v0, Landroid/media/TimedTextEx;->mLanguageCount:I

    if-gtz v5, :cond_1

    :cond_0
    return-void

    :cond_1
    move-object/from16 v0, p0

    iget-object v5, v0, Landroid/media/TimedTextEx;->mEraseDisMem:Ljava/util/ArrayList;

    if-nez v5, :cond_2

    new-instance v24, Landroid/media/TimedTextEx$EraseDisplayMemory;

    const/4 v5, -0x1

    move-object/from16 v0, v24

    invoke-direct {v0, v5}, Landroid/media/TimedTextEx$EraseDisplayMemory;-><init>(I)V

    .local v24, "eraseDisMem":Landroid/media/TimedTextEx$EraseDisplayMemory;
    new-instance v5, Ljava/util/ArrayList;

    invoke-direct {v5}, Ljava/util/ArrayList;-><init>()V

    move-object/from16 v0, p0

    iput-object v5, v0, Landroid/media/TimedTextEx;->mEraseDisMem:Ljava/util/ArrayList;

    const/16 v28, 0x0

    .local v28, "i":I
    :goto_0
    move-object/from16 v0, p0

    iget v5, v0, Landroid/media/TimedTextEx;->mLanguageCount:I

    move/from16 v0, v28

    if-ge v0, v5, :cond_2

    move-object/from16 v0, p0

    iget-object v5, v0, Landroid/media/TimedTextEx;->mEraseDisMem:Ljava/util/ArrayList;

    move-object/from16 v0, v24

    invoke-virtual {v5, v0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    add-int/lit8 v28, v28, 0x1

    goto :goto_0

    .end local v24    # "eraseDisMem":Landroid/media/TimedTextEx$EraseDisplayMemory;
    .end local v28    # "i":I
    :cond_2
    move-object/from16 v0, p0

    iget-object v5, v0, Landroid/media/TimedTextEx;->mResumeCaption:Ljava/util/ArrayList;

    if-nez v5, :cond_3

    new-instance v31, Landroid/media/TimedTextEx$ResumeCaptionLoading;

    const/4 v5, -0x1

    move-object/from16 v0, v31

    invoke-direct {v0, v5}, Landroid/media/TimedTextEx$ResumeCaptionLoading;-><init>(I)V

    .local v31, "resumeCaption":Landroid/media/TimedTextEx$ResumeCaptionLoading;
    new-instance v5, Ljava/util/ArrayList;

    invoke-direct {v5}, Ljava/util/ArrayList;-><init>()V

    move-object/from16 v0, p0

    iput-object v5, v0, Landroid/media/TimedTextEx;->mResumeCaption:Ljava/util/ArrayList;

    const/16 v28, 0x0

    .restart local v28    # "i":I
    :goto_1
    move-object/from16 v0, p0

    iget v5, v0, Landroid/media/TimedTextEx;->mLanguageCount:I

    move/from16 v0, v28

    if-ge v0, v5, :cond_3

    move-object/from16 v0, p0

    iget-object v5, v0, Landroid/media/TimedTextEx;->mResumeCaption:Ljava/util/ArrayList;

    move-object/from16 v0, v31

    invoke-virtual {v5, v0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    add-int/lit8 v28, v28, 0x1

    goto :goto_1

    .end local v28    # "i":I
    .end local v31    # "resumeCaption":Landroid/media/TimedTextEx$ResumeCaptionLoading;
    :cond_3
    move-object/from16 v0, p0

    iget-object v5, v0, Landroid/media/TimedTextEx;->mEndofCaption:Ljava/util/ArrayList;

    if-nez v5, :cond_4

    new-instance v23, Landroid/media/TimedTextEx$EndOfCaption;

    const/4 v5, -0x1

    move-object/from16 v0, v23

    invoke-direct {v0, v5}, Landroid/media/TimedTextEx$EndOfCaption;-><init>(I)V

    .local v23, "endofCaption":Landroid/media/TimedTextEx$EndOfCaption;
    new-instance v5, Ljava/util/ArrayList;

    invoke-direct {v5}, Ljava/util/ArrayList;-><init>()V

    move-object/from16 v0, p0

    iput-object v5, v0, Landroid/media/TimedTextEx;->mEndofCaption:Ljava/util/ArrayList;

    const/16 v28, 0x0

    .restart local v28    # "i":I
    :goto_2
    move-object/from16 v0, p0

    iget v5, v0, Landroid/media/TimedTextEx;->mLanguageCount:I

    move/from16 v0, v28

    if-ge v0, v5, :cond_4

    move-object/from16 v0, p0

    iget-object v5, v0, Landroid/media/TimedTextEx;->mEndofCaption:Ljava/util/ArrayList;

    move-object/from16 v0, v23

    invoke-virtual {v5, v0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    add-int/lit8 v28, v28, 0x1

    goto :goto_2

    .end local v23    # "endofCaption":Landroid/media/TimedTextEx$EndOfCaption;
    .end local v28    # "i":I
    :cond_4
    move-object/from16 v0, p0

    iget-object v5, v0, Landroid/media/TimedTextEx;->mTapOffset1:Ljava/util/ArrayList;

    if-nez v5, :cond_5

    new-instance v38, Landroid/media/TimedTextEx$TapOffset1;

    const/4 v5, -0x1

    move-object/from16 v0, v38

    invoke-direct {v0, v5}, Landroid/media/TimedTextEx$TapOffset1;-><init>(I)V

    .local v38, "tapOffset1":Landroid/media/TimedTextEx$TapOffset1;
    new-instance v5, Ljava/util/ArrayList;

    invoke-direct {v5}, Ljava/util/ArrayList;-><init>()V

    move-object/from16 v0, p0

    iput-object v5, v0, Landroid/media/TimedTextEx;->mTapOffset1:Ljava/util/ArrayList;

    const/16 v28, 0x0

    .restart local v28    # "i":I
    :goto_3
    move-object/from16 v0, p0

    iget v5, v0, Landroid/media/TimedTextEx;->mLanguageCount:I

    move/from16 v0, v28

    if-ge v0, v5, :cond_5

    move-object/from16 v0, p0

    iget-object v5, v0, Landroid/media/TimedTextEx;->mTapOffset1:Ljava/util/ArrayList;

    move-object/from16 v0, v38

    invoke-virtual {v5, v0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    add-int/lit8 v28, v28, 0x1

    goto :goto_3

    .end local v28    # "i":I
    .end local v38    # "tapOffset1":Landroid/media/TimedTextEx$TapOffset1;
    :cond_5
    move-object/from16 v0, p0

    iget-object v5, v0, Landroid/media/TimedTextEx;->mTapOffset2:Ljava/util/ArrayList;

    if-nez v5, :cond_6

    new-instance v39, Landroid/media/TimedTextEx$TapOffset2;

    const/4 v5, -0x1

    move-object/from16 v0, v39

    invoke-direct {v0, v5}, Landroid/media/TimedTextEx$TapOffset2;-><init>(I)V

    .local v39, "tapOffset2":Landroid/media/TimedTextEx$TapOffset2;
    new-instance v5, Ljava/util/ArrayList;

    invoke-direct {v5}, Ljava/util/ArrayList;-><init>()V

    move-object/from16 v0, p0

    iput-object v5, v0, Landroid/media/TimedTextEx;->mTapOffset2:Ljava/util/ArrayList;

    const/16 v28, 0x0

    .restart local v28    # "i":I
    :goto_4
    move-object/from16 v0, p0

    iget v5, v0, Landroid/media/TimedTextEx;->mLanguageCount:I

    move/from16 v0, v28

    if-ge v0, v5, :cond_6

    move-object/from16 v0, p0

    iget-object v5, v0, Landroid/media/TimedTextEx;->mTapOffset2:Ljava/util/ArrayList;

    move-object/from16 v0, v39

    invoke-virtual {v5, v0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    add-int/lit8 v28, v28, 0x1

    goto :goto_4

    .end local v28    # "i":I
    .end local v39    # "tapOffset2":Landroid/media/TimedTextEx$TapOffset2;
    :cond_6
    move-object/from16 v0, p0

    iget-object v5, v0, Landroid/media/TimedTextEx;->mTapOffset3:Ljava/util/ArrayList;

    if-nez v5, :cond_7

    new-instance v40, Landroid/media/TimedTextEx$TapOffset3;

    const/4 v5, -0x1

    move-object/from16 v0, v40

    invoke-direct {v0, v5}, Landroid/media/TimedTextEx$TapOffset3;-><init>(I)V

    .local v40, "tapOffset3":Landroid/media/TimedTextEx$TapOffset3;
    new-instance v5, Ljava/util/ArrayList;

    invoke-direct {v5}, Ljava/util/ArrayList;-><init>()V

    move-object/from16 v0, p0

    iput-object v5, v0, Landroid/media/TimedTextEx;->mTapOffset3:Ljava/util/ArrayList;

    const/16 v28, 0x0

    .restart local v28    # "i":I
    :goto_5
    move-object/from16 v0, p0

    iget v5, v0, Landroid/media/TimedTextEx;->mLanguageCount:I

    move/from16 v0, v28

    if-ge v0, v5, :cond_7

    move-object/from16 v0, p0

    iget-object v5, v0, Landroid/media/TimedTextEx;->mTapOffset3:Ljava/util/ArrayList;

    move-object/from16 v0, v40

    invoke-virtual {v5, v0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    add-int/lit8 v28, v28, 0x1

    goto :goto_5

    .end local v28    # "i":I
    .end local v40    # "tapOffset3":Landroid/media/TimedTextEx$TapOffset3;
    :cond_7
    move-object/from16 v0, p0

    iget-object v5, v0, Landroid/media/TimedTextEx;->mRollup2:Ljava/util/ArrayList;

    if-nez v5, :cond_8

    new-instance v33, Landroid/media/TimedTextEx$Rollup2;

    const/4 v5, -0x1

    move-object/from16 v0, v33

    invoke-direct {v0, v5}, Landroid/media/TimedTextEx$Rollup2;-><init>(I)V

    .local v33, "rollup2":Landroid/media/TimedTextEx$Rollup2;
    new-instance v5, Ljava/util/ArrayList;

    invoke-direct {v5}, Ljava/util/ArrayList;-><init>()V

    move-object/from16 v0, p0

    iput-object v5, v0, Landroid/media/TimedTextEx;->mRollup2:Ljava/util/ArrayList;

    const/16 v28, 0x0

    .restart local v28    # "i":I
    :goto_6
    move-object/from16 v0, p0

    iget v5, v0, Landroid/media/TimedTextEx;->mLanguageCount:I

    move/from16 v0, v28

    if-ge v0, v5, :cond_8

    move-object/from16 v0, p0

    iget-object v5, v0, Landroid/media/TimedTextEx;->mRollup2:Ljava/util/ArrayList;

    move-object/from16 v0, v33

    invoke-virtual {v5, v0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    add-int/lit8 v28, v28, 0x1

    goto :goto_6

    .end local v28    # "i":I
    .end local v33    # "rollup2":Landroid/media/TimedTextEx$Rollup2;
    :cond_8
    move-object/from16 v0, p0

    iget-object v5, v0, Landroid/media/TimedTextEx;->mRollup3:Ljava/util/ArrayList;

    if-nez v5, :cond_9

    new-instance v34, Landroid/media/TimedTextEx$Rollup3;

    const/4 v5, -0x1

    move-object/from16 v0, v34

    invoke-direct {v0, v5}, Landroid/media/TimedTextEx$Rollup3;-><init>(I)V

    .local v34, "rollup3":Landroid/media/TimedTextEx$Rollup3;
    new-instance v5, Ljava/util/ArrayList;

    invoke-direct {v5}, Ljava/util/ArrayList;-><init>()V

    move-object/from16 v0, p0

    iput-object v5, v0, Landroid/media/TimedTextEx;->mRollup3:Ljava/util/ArrayList;

    const/16 v28, 0x0

    .restart local v28    # "i":I
    :goto_7
    move-object/from16 v0, p0

    iget v5, v0, Landroid/media/TimedTextEx;->mLanguageCount:I

    move/from16 v0, v28

    if-ge v0, v5, :cond_9

    move-object/from16 v0, p0

    iget-object v5, v0, Landroid/media/TimedTextEx;->mRollup3:Ljava/util/ArrayList;

    move-object/from16 v0, v34

    invoke-virtual {v5, v0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    add-int/lit8 v28, v28, 0x1

    goto :goto_7

    .end local v28    # "i":I
    .end local v34    # "rollup3":Landroid/media/TimedTextEx$Rollup3;
    :cond_9
    move-object/from16 v0, p0

    iget-object v5, v0, Landroid/media/TimedTextEx;->mRollup4:Ljava/util/ArrayList;

    if-nez v5, :cond_a

    new-instance v35, Landroid/media/TimedTextEx$Rollup4;

    const/4 v5, -0x1

    move-object/from16 v0, v35

    invoke-direct {v0, v5}, Landroid/media/TimedTextEx$Rollup4;-><init>(I)V

    .local v35, "rollup4":Landroid/media/TimedTextEx$Rollup4;
    new-instance v5, Ljava/util/ArrayList;

    invoke-direct {v5}, Ljava/util/ArrayList;-><init>()V

    move-object/from16 v0, p0

    iput-object v5, v0, Landroid/media/TimedTextEx;->mRollup4:Ljava/util/ArrayList;

    const/16 v28, 0x0

    .restart local v28    # "i":I
    :goto_8
    move-object/from16 v0, p0

    iget v5, v0, Landroid/media/TimedTextEx;->mLanguageCount:I

    move/from16 v0, v28

    if-ge v0, v5, :cond_a

    move-object/from16 v0, p0

    iget-object v5, v0, Landroid/media/TimedTextEx;->mRollup4:Ljava/util/ArrayList;

    move-object/from16 v0, v35

    invoke-virtual {v5, v0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    add-int/lit8 v28, v28, 0x1

    goto :goto_8

    .end local v28    # "i":I
    .end local v35    # "rollup4":Landroid/media/TimedTextEx$Rollup4;
    :cond_a
    move-object/from16 v0, p0

    iget-object v5, v0, Landroid/media/TimedTextEx;->mCR:Ljava/util/ArrayList;

    if-nez v5, :cond_b

    new-instance v15, Landroid/media/TimedTextEx$CarriageReturn;

    const/4 v5, -0x1

    invoke-direct {v15, v5}, Landroid/media/TimedTextEx$CarriageReturn;-><init>(I)V

    .local v15, "CR":Landroid/media/TimedTextEx$CarriageReturn;
    new-instance v5, Ljava/util/ArrayList;

    invoke-direct {v5}, Ljava/util/ArrayList;-><init>()V

    move-object/from16 v0, p0

    iput-object v5, v0, Landroid/media/TimedTextEx;->mCR:Ljava/util/ArrayList;

    const/16 v28, 0x0

    .restart local v28    # "i":I
    :goto_9
    move-object/from16 v0, p0

    iget v5, v0, Landroid/media/TimedTextEx;->mLanguageCount:I

    move/from16 v0, v28

    if-ge v0, v5, :cond_b

    move-object/from16 v0, p0

    iget-object v5, v0, Landroid/media/TimedTextEx;->mCR:Ljava/util/ArrayList;

    invoke-virtual {v5, v15}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    add-int/lit8 v28, v28, 0x1

    goto :goto_9

    .end local v15    # "CR":Landroid/media/TimedTextEx$CarriageReturn;
    .end local v28    # "i":I
    :cond_b
    move-object/from16 v0, p0

    iget-object v5, v0, Landroid/media/TimedTextEx;->mEraseNonDisMem:Ljava/util/ArrayList;

    if-nez v5, :cond_c

    new-instance v25, Landroid/media/TimedTextEx$EraseNondisplayMemory;

    const/4 v5, -0x1

    move-object/from16 v0, v25

    invoke-direct {v0, v5}, Landroid/media/TimedTextEx$EraseNondisplayMemory;-><init>(I)V

    .local v25, "eraseNonDisMem":Landroid/media/TimedTextEx$EraseNondisplayMemory;
    new-instance v5, Ljava/util/ArrayList;

    invoke-direct {v5}, Ljava/util/ArrayList;-><init>()V

    move-object/from16 v0, p0

    iput-object v5, v0, Landroid/media/TimedTextEx;->mEraseNonDisMem:Ljava/util/ArrayList;

    const/16 v28, 0x0

    .restart local v28    # "i":I
    :goto_a
    move-object/from16 v0, p0

    iget v5, v0, Landroid/media/TimedTextEx;->mLanguageCount:I

    move/from16 v0, v28

    if-ge v0, v5, :cond_c

    move-object/from16 v0, p0

    iget-object v5, v0, Landroid/media/TimedTextEx;->mEraseNonDisMem:Ljava/util/ArrayList;

    move-object/from16 v0, v25

    invoke-virtual {v5, v0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    add-int/lit8 v28, v28, 0x1

    goto :goto_a

    .end local v25    # "eraseNonDisMem":Landroid/media/TimedTextEx$EraseNondisplayMemory;
    .end local v28    # "i":I
    :cond_c
    move-object/from16 v0, p0

    iget-object v5, v0, Landroid/media/TimedTextEx;->mBackspace:Ljava/util/ArrayList;

    if-nez v5, :cond_d

    new-instance v17, Landroid/media/TimedTextEx$Backspace;

    const/4 v5, -0x1

    move-object/from16 v0, v17

    invoke-direct {v0, v5}, Landroid/media/TimedTextEx$Backspace;-><init>(I)V

    .local v17, "backSpace":Landroid/media/TimedTextEx$Backspace;
    new-instance v5, Ljava/util/ArrayList;

    invoke-direct {v5}, Ljava/util/ArrayList;-><init>()V

    move-object/from16 v0, p0

    iput-object v5, v0, Landroid/media/TimedTextEx;->mBackspace:Ljava/util/ArrayList;

    const/16 v28, 0x0

    .restart local v28    # "i":I
    :goto_b
    move-object/from16 v0, p0

    iget v5, v0, Landroid/media/TimedTextEx;->mLanguageCount:I

    move/from16 v0, v28

    if-ge v0, v5, :cond_d

    move-object/from16 v0, p0

    iget-object v5, v0, Landroid/media/TimedTextEx;->mBackspace:Ljava/util/ArrayList;

    move-object/from16 v0, v17

    invoke-virtual {v5, v0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    add-int/lit8 v28, v28, 0x1

    goto :goto_b

    .end local v17    # "backSpace":Landroid/media/TimedTextEx$Backspace;
    .end local v28    # "i":I
    :cond_d
    move-object/from16 v0, p0

    iget-object v5, v0, Landroid/media/TimedTextEx;->mResumeTextDis:Ljava/util/ArrayList;

    if-nez v5, :cond_e

    new-instance v32, Landroid/media/TimedTextEx$ResumeTextDisplay;

    const/4 v5, -0x1

    move-object/from16 v0, v32

    invoke-direct {v0, v5}, Landroid/media/TimedTextEx$ResumeTextDisplay;-><init>(I)V

    .local v32, "resumeTextDis":Landroid/media/TimedTextEx$ResumeTextDisplay;
    new-instance v5, Ljava/util/ArrayList;

    invoke-direct {v5}, Ljava/util/ArrayList;-><init>()V

    move-object/from16 v0, p0

    iput-object v5, v0, Landroid/media/TimedTextEx;->mResumeTextDis:Ljava/util/ArrayList;

    const/16 v28, 0x0

    .restart local v28    # "i":I
    :goto_c
    move-object/from16 v0, p0

    iget v5, v0, Landroid/media/TimedTextEx;->mLanguageCount:I

    move/from16 v0, v28

    if-ge v0, v5, :cond_e

    move-object/from16 v0, p0

    iget-object v5, v0, Landroid/media/TimedTextEx;->mResumeTextDis:Ljava/util/ArrayList;

    move-object/from16 v0, v32

    invoke-virtual {v5, v0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    add-int/lit8 v28, v28, 0x1

    goto :goto_c

    .end local v28    # "i":I
    .end local v32    # "resumeTextDis":Landroid/media/TimedTextEx$ResumeTextDisplay;
    :cond_e
    move-object/from16 v0, p0

    iget-object v5, v0, Landroid/media/TimedTextEx;->mPreambleAdressCode:Ljava/util/ArrayList;

    if-nez v5, :cond_f

    new-instance v29, Landroid/media/TimedTextEx$PreambleAdressCode;

    const/4 v5, -0x1

    const/4 v6, -0x1

    const/4 v7, -0x1

    const/4 v8, -0x1

    move-object/from16 v0, v29

    invoke-direct {v0, v5, v6, v7, v8}, Landroid/media/TimedTextEx$PreambleAdressCode;-><init>(IIII)V

    .local v29, "preambleAdressCode":Landroid/media/TimedTextEx$PreambleAdressCode;
    new-instance v5, Ljava/util/ArrayList;

    invoke-direct {v5}, Ljava/util/ArrayList;-><init>()V

    move-object/from16 v0, p0

    iput-object v5, v0, Landroid/media/TimedTextEx;->mPreambleAdressCode:Ljava/util/ArrayList;

    const/16 v28, 0x0

    .restart local v28    # "i":I
    :goto_d
    move-object/from16 v0, p0

    iget v5, v0, Landroid/media/TimedTextEx;->mLanguageCount:I

    move/from16 v0, v28

    if-ge v0, v5, :cond_f

    move-object/from16 v0, p0

    iget-object v5, v0, Landroid/media/TimedTextEx;->mPreambleAdressCode:Ljava/util/ArrayList;

    move-object/from16 v0, v29

    invoke-virtual {v5, v0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    add-int/lit8 v28, v28, 0x1

    goto :goto_d

    .end local v28    # "i":I
    .end local v29    # "preambleAdressCode":Landroid/media/TimedTextEx$PreambleAdressCode;
    :cond_f
    move-object/from16 v0, p0

    iget-object v5, v0, Landroid/media/TimedTextEx;->mTextAttribute:Ljava/util/ArrayList;

    if-nez v5, :cond_10

    new-instance v41, Landroid/media/TimedTextEx$TextAttribute;

    const/4 v5, -0x1

    const/4 v6, -0x1

    move-object/from16 v0, v41

    invoke-direct {v0, v5, v6}, Landroid/media/TimedTextEx$TextAttribute;-><init>(II)V

    .local v41, "textAttribute":Landroid/media/TimedTextEx$TextAttribute;
    new-instance v5, Ljava/util/ArrayList;

    invoke-direct {v5}, Ljava/util/ArrayList;-><init>()V

    move-object/from16 v0, p0

    iput-object v5, v0, Landroid/media/TimedTextEx;->mTextAttribute:Ljava/util/ArrayList;

    const/16 v28, 0x0

    .restart local v28    # "i":I
    :goto_e
    move-object/from16 v0, p0

    iget v5, v0, Landroid/media/TimedTextEx;->mLanguageCount:I

    move/from16 v0, v28

    if-ge v0, v5, :cond_10

    move-object/from16 v0, p0

    iget-object v5, v0, Landroid/media/TimedTextEx;->mTextAttribute:Ljava/util/ArrayList;

    move-object/from16 v0, v41

    invoke-virtual {v5, v0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    add-int/lit8 v28, v28, 0x1

    goto :goto_e

    .end local v28    # "i":I
    .end local v41    # "textAttribute":Landroid/media/TimedTextEx$TextAttribute;
    :cond_10
    move-object/from16 v0, p0

    iget-object v5, v0, Landroid/media/TimedTextEx;->mSetCurWin:Ljava/util/ArrayList;

    if-nez v5, :cond_11

    new-instance v36, Landroid/media/TimedTextEx$SetCurrentWindow;

    const/4 v5, -0x1

    move-object/from16 v0, v36

    invoke-direct {v0, v5}, Landroid/media/TimedTextEx$SetCurrentWindow;-><init>(I)V

    .local v36, "setCurWin":Landroid/media/TimedTextEx$SetCurrentWindow;
    new-instance v5, Ljava/util/ArrayList;

    invoke-direct {v5}, Ljava/util/ArrayList;-><init>()V

    move-object/from16 v0, p0

    iput-object v5, v0, Landroid/media/TimedTextEx;->mSetCurWin:Ljava/util/ArrayList;

    const/16 v28, 0x0

    .restart local v28    # "i":I
    :goto_f
    move-object/from16 v0, p0

    iget v5, v0, Landroid/media/TimedTextEx;->mLanguageCount:I

    move/from16 v0, v28

    if-ge v0, v5, :cond_11

    move-object/from16 v0, p0

    iget-object v5, v0, Landroid/media/TimedTextEx;->mSetCurWin:Ljava/util/ArrayList;

    move-object/from16 v0, v36

    invoke-virtual {v5, v0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    add-int/lit8 v28, v28, 0x1

    goto :goto_f

    .end local v28    # "i":I
    .end local v36    # "setCurWin":Landroid/media/TimedTextEx$SetCurrentWindow;
    :cond_11
    move-object/from16 v0, p0

    iget-object v5, v0, Landroid/media/TimedTextEx;->mClearWins:Ljava/util/ArrayList;

    if-nez v5, :cond_12

    new-instance v19, Landroid/media/TimedTextEx$ClearWindows;

    const/4 v5, -0x1

    move-object/from16 v0, v19

    invoke-direct {v0, v5}, Landroid/media/TimedTextEx$ClearWindows;-><init>(I)V

    .local v19, "clearWins":Landroid/media/TimedTextEx$ClearWindows;
    new-instance v5, Ljava/util/ArrayList;

    invoke-direct {v5}, Ljava/util/ArrayList;-><init>()V

    move-object/from16 v0, p0

    iput-object v5, v0, Landroid/media/TimedTextEx;->mClearWins:Ljava/util/ArrayList;

    const/16 v28, 0x0

    .restart local v28    # "i":I
    :goto_10
    move-object/from16 v0, p0

    iget v5, v0, Landroid/media/TimedTextEx;->mLanguageCount:I

    move/from16 v0, v28

    if-ge v0, v5, :cond_12

    move-object/from16 v0, p0

    iget-object v5, v0, Landroid/media/TimedTextEx;->mClearWins:Ljava/util/ArrayList;

    move-object/from16 v0, v19

    invoke-virtual {v5, v0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    add-int/lit8 v28, v28, 0x1

    goto :goto_10

    .end local v19    # "clearWins":Landroid/media/TimedTextEx$ClearWindows;
    .end local v28    # "i":I
    :cond_12
    move-object/from16 v0, p0

    iget-object v5, v0, Landroid/media/TimedTextEx;->mDefineWin:Ljava/util/ArrayList;

    if-nez v5, :cond_13

    new-instance v1, Landroid/media/TimedTextEx$DefineWindow;

    const/4 v2, -0x1

    const/4 v3, -0x1

    const/4 v4, -0x1

    const/4 v5, -0x1

    const/4 v6, -0x1

    const/4 v7, -0x1

    const/4 v8, -0x1

    const/4 v9, -0x1

    const/4 v10, -0x1

    const/4 v11, -0x1

    const/4 v12, -0x1

    const/4 v13, -0x1

    const/4 v14, -0x1

    invoke-direct/range {v1 .. v14}, Landroid/media/TimedTextEx$DefineWindow;-><init>(IIIIIIIIIIIII)V

    .local v1, "defineWin":Landroid/media/TimedTextEx$DefineWindow;
    new-instance v5, Ljava/util/ArrayList;

    invoke-direct {v5}, Ljava/util/ArrayList;-><init>()V

    move-object/from16 v0, p0

    iput-object v5, v0, Landroid/media/TimedTextEx;->mDefineWin:Ljava/util/ArrayList;

    const/16 v28, 0x0

    .restart local v28    # "i":I
    :goto_11
    move-object/from16 v0, p0

    iget v5, v0, Landroid/media/TimedTextEx;->mLanguageCount:I

    move/from16 v0, v28

    if-ge v0, v5, :cond_13

    move-object/from16 v0, p0

    iget-object v5, v0, Landroid/media/TimedTextEx;->mDefineWin:Ljava/util/ArrayList;

    invoke-virtual {v5, v1}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    add-int/lit8 v28, v28, 0x1

    goto :goto_11

    .end local v1    # "defineWin":Landroid/media/TimedTextEx$DefineWindow;
    .end local v28    # "i":I
    :cond_13
    move-object/from16 v0, p0

    iget-object v5, v0, Landroid/media/TimedTextEx;->mDelWins:Ljava/util/ArrayList;

    if-nez v5, :cond_14

    new-instance v21, Landroid/media/TimedTextEx$DeleteWindows;

    const/4 v5, -0x1

    move-object/from16 v0, v21

    invoke-direct {v0, v5}, Landroid/media/TimedTextEx$DeleteWindows;-><init>(I)V

    .local v21, "delWins":Landroid/media/TimedTextEx$DeleteWindows;
    new-instance v5, Ljava/util/ArrayList;

    invoke-direct {v5}, Ljava/util/ArrayList;-><init>()V

    move-object/from16 v0, p0

    iput-object v5, v0, Landroid/media/TimedTextEx;->mDelWins:Ljava/util/ArrayList;

    const/16 v28, 0x0

    .restart local v28    # "i":I
    :goto_12
    move-object/from16 v0, p0

    iget v5, v0, Landroid/media/TimedTextEx;->mLanguageCount:I

    move/from16 v0, v28

    if-ge v0, v5, :cond_14

    move-object/from16 v0, p0

    iget-object v5, v0, Landroid/media/TimedTextEx;->mDelWins:Ljava/util/ArrayList;

    move-object/from16 v0, v21

    invoke-virtual {v5, v0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    add-int/lit8 v28, v28, 0x1

    goto :goto_12

    .end local v21    # "delWins":Landroid/media/TimedTextEx$DeleteWindows;
    .end local v28    # "i":I
    :cond_14
    move-object/from16 v0, p0

    iget-object v5, v0, Landroid/media/TimedTextEx;->mDisplayWins:Ljava/util/ArrayList;

    if-nez v5, :cond_15

    new-instance v22, Landroid/media/TimedTextEx$DisplayWindows;

    const/4 v5, -0x1

    move-object/from16 v0, v22

    invoke-direct {v0, v5}, Landroid/media/TimedTextEx$DisplayWindows;-><init>(I)V

    .local v22, "displayWins":Landroid/media/TimedTextEx$DisplayWindows;
    new-instance v5, Ljava/util/ArrayList;

    invoke-direct {v5}, Ljava/util/ArrayList;-><init>()V

    move-object/from16 v0, p0

    iput-object v5, v0, Landroid/media/TimedTextEx;->mDisplayWins:Ljava/util/ArrayList;

    const/16 v28, 0x0

    .restart local v28    # "i":I
    :goto_13
    move-object/from16 v0, p0

    iget v5, v0, Landroid/media/TimedTextEx;->mLanguageCount:I

    move/from16 v0, v28

    if-ge v0, v5, :cond_15

    move-object/from16 v0, p0

    iget-object v5, v0, Landroid/media/TimedTextEx;->mDisplayWins:Ljava/util/ArrayList;

    move-object/from16 v0, v22

    invoke-virtual {v5, v0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    add-int/lit8 v28, v28, 0x1

    goto :goto_13

    .end local v22    # "displayWins":Landroid/media/TimedTextEx$DisplayWindows;
    .end local v28    # "i":I
    :cond_15
    move-object/from16 v0, p0

    iget-object v5, v0, Landroid/media/TimedTextEx;->mHideWins:Ljava/util/ArrayList;

    if-nez v5, :cond_16

    new-instance v26, Landroid/media/TimedTextEx$HideWindows;

    const/4 v5, -0x1

    move-object/from16 v0, v26

    invoke-direct {v0, v5}, Landroid/media/TimedTextEx$HideWindows;-><init>(I)V

    .local v26, "hideWins":Landroid/media/TimedTextEx$HideWindows;
    new-instance v5, Ljava/util/ArrayList;

    invoke-direct {v5}, Ljava/util/ArrayList;-><init>()V

    move-object/from16 v0, p0

    iput-object v5, v0, Landroid/media/TimedTextEx;->mHideWins:Ljava/util/ArrayList;

    const/16 v28, 0x0

    .restart local v28    # "i":I
    :goto_14
    move-object/from16 v0, p0

    iget v5, v0, Landroid/media/TimedTextEx;->mLanguageCount:I

    move/from16 v0, v28

    if-ge v0, v5, :cond_16

    move-object/from16 v0, p0

    iget-object v5, v0, Landroid/media/TimedTextEx;->mHideWins:Ljava/util/ArrayList;

    move-object/from16 v0, v26

    invoke-virtual {v5, v0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    add-int/lit8 v28, v28, 0x1

    goto :goto_14

    .end local v26    # "hideWins":Landroid/media/TimedTextEx$HideWindows;
    .end local v28    # "i":I
    :cond_16
    move-object/from16 v0, p0

    iget-object v5, v0, Landroid/media/TimedTextEx;->mToggleWins:Ljava/util/ArrayList;

    if-nez v5, :cond_17

    new-instance v42, Landroid/media/TimedTextEx$ToggleWindows;

    const/4 v5, -0x1

    move-object/from16 v0, v42

    invoke-direct {v0, v5}, Landroid/media/TimedTextEx$ToggleWindows;-><init>(I)V

    .local v42, "toggleWins":Landroid/media/TimedTextEx$ToggleWindows;
    new-instance v5, Ljava/util/ArrayList;

    invoke-direct {v5}, Ljava/util/ArrayList;-><init>()V

    move-object/from16 v0, p0

    iput-object v5, v0, Landroid/media/TimedTextEx;->mToggleWins:Ljava/util/ArrayList;

    const/16 v28, 0x0

    .restart local v28    # "i":I
    :goto_15
    move-object/from16 v0, p0

    iget v5, v0, Landroid/media/TimedTextEx;->mLanguageCount:I

    move/from16 v0, v28

    if-ge v0, v5, :cond_17

    move-object/from16 v0, p0

    iget-object v5, v0, Landroid/media/TimedTextEx;->mToggleWins:Ljava/util/ArrayList;

    move-object/from16 v0, v42

    invoke-virtual {v5, v0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    add-int/lit8 v28, v28, 0x1

    goto :goto_15

    .end local v28    # "i":I
    .end local v42    # "toggleWins":Landroid/media/TimedTextEx$ToggleWindows;
    :cond_17
    move-object/from16 v0, p0

    iget-object v5, v0, Landroid/media/TimedTextEx;->mSetWinAttribute:Ljava/util/ArrayList;

    if-nez v5, :cond_18

    new-instance v2, Landroid/media/TimedTextEx$SetWindowAttribute;

    const/4 v3, -0x1

    const/4 v4, -0x1

    const/4 v5, -0x1

    const/4 v6, -0x1

    const/4 v7, -0x1

    const/4 v8, -0x1

    const/4 v9, -0x1

    const/4 v10, -0x1

    const/4 v11, -0x1

    const/4 v12, -0x1

    const/4 v13, -0x1

    invoke-direct/range {v2 .. v13}, Landroid/media/TimedTextEx$SetWindowAttribute;-><init>(IIIIIIIIIII)V

    .local v2, "setWinAttribute":Landroid/media/TimedTextEx$SetWindowAttribute;
    new-instance v5, Ljava/util/ArrayList;

    invoke-direct {v5}, Ljava/util/ArrayList;-><init>()V

    move-object/from16 v0, p0

    iput-object v5, v0, Landroid/media/TimedTextEx;->mSetWinAttribute:Ljava/util/ArrayList;

    const/16 v28, 0x0

    .restart local v28    # "i":I
    :goto_16
    move-object/from16 v0, p0

    iget v5, v0, Landroid/media/TimedTextEx;->mLanguageCount:I

    move/from16 v0, v28

    if-ge v0, v5, :cond_18

    move-object/from16 v0, p0

    iget-object v5, v0, Landroid/media/TimedTextEx;->mSetWinAttribute:Ljava/util/ArrayList;

    invoke-virtual {v5, v2}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    add-int/lit8 v28, v28, 0x1

    goto :goto_16

    .end local v2    # "setWinAttribute":Landroid/media/TimedTextEx$SetWindowAttribute;
    .end local v28    # "i":I
    :cond_18
    move-object/from16 v0, p0

    iget-object v5, v0, Landroid/media/TimedTextEx;->mSetPenAttribute:Ljava/util/ArrayList;

    if-nez v5, :cond_19

    new-instance v3, Landroid/media/TimedTextEx$SetPenAttribute;

    const/4 v4, -0x1

    const/4 v5, -0x1

    const/4 v6, -0x1

    const/4 v7, -0x1

    const/4 v8, -0x1

    const/4 v9, -0x1

    const/4 v10, -0x1

    invoke-direct/range {v3 .. v10}, Landroid/media/TimedTextEx$SetPenAttribute;-><init>(IIIIIII)V

    .local v3, "setPenAttribute":Landroid/media/TimedTextEx$SetPenAttribute;
    new-instance v5, Ljava/util/ArrayList;

    invoke-direct {v5}, Ljava/util/ArrayList;-><init>()V

    move-object/from16 v0, p0

    iput-object v5, v0, Landroid/media/TimedTextEx;->mSetPenAttribute:Ljava/util/ArrayList;

    const/16 v28, 0x0

    .restart local v28    # "i":I
    :goto_17
    move-object/from16 v0, p0

    iget v5, v0, Landroid/media/TimedTextEx;->mLanguageCount:I

    move/from16 v0, v28

    if-ge v0, v5, :cond_19

    move-object/from16 v0, p0

    iget-object v5, v0, Landroid/media/TimedTextEx;->mSetPenAttribute:Ljava/util/ArrayList;

    invoke-virtual {v5, v3}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    add-int/lit8 v28, v28, 0x1

    goto :goto_17

    .end local v3    # "setPenAttribute":Landroid/media/TimedTextEx$SetPenAttribute;
    .end local v28    # "i":I
    :cond_19
    move-object/from16 v0, p0

    iget-object v5, v0, Landroid/media/TimedTextEx;->mSetPenColor:Ljava/util/ArrayList;

    if-nez v5, :cond_1a

    new-instance v4, Landroid/media/TimedTextEx$SetPenColor;

    const/4 v5, -0x1

    const/4 v6, -0x1

    const/4 v7, -0x1

    const/4 v8, -0x1

    const/4 v9, -0x1

    invoke-direct/range {v4 .. v9}, Landroid/media/TimedTextEx$SetPenColor;-><init>(IIIII)V

    .local v4, "setPenColor":Landroid/media/TimedTextEx$SetPenColor;
    new-instance v5, Ljava/util/ArrayList;

    invoke-direct {v5}, Ljava/util/ArrayList;-><init>()V

    move-object/from16 v0, p0

    iput-object v5, v0, Landroid/media/TimedTextEx;->mSetPenColor:Ljava/util/ArrayList;

    const/16 v28, 0x0

    .restart local v28    # "i":I
    :goto_18
    move-object/from16 v0, p0

    iget v5, v0, Landroid/media/TimedTextEx;->mLanguageCount:I

    move/from16 v0, v28

    if-ge v0, v5, :cond_1a

    move-object/from16 v0, p0

    iget-object v5, v0, Landroid/media/TimedTextEx;->mSetPenColor:Ljava/util/ArrayList;

    invoke-virtual {v5, v4}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    add-int/lit8 v28, v28, 0x1

    goto :goto_18

    .end local v4    # "setPenColor":Landroid/media/TimedTextEx$SetPenColor;
    .end local v28    # "i":I
    :cond_1a
    move-object/from16 v0, p0

    iget-object v5, v0, Landroid/media/TimedTextEx;->mSetPenLocation:Ljava/util/ArrayList;

    if-nez v5, :cond_1b

    new-instance v37, Landroid/media/TimedTextEx$SetPenLocation;

    const/4 v5, -0x1

    const/4 v6, -0x1

    move-object/from16 v0, v37

    invoke-direct {v0, v5, v6}, Landroid/media/TimedTextEx$SetPenLocation;-><init>(II)V

    .local v37, "setPenLocation":Landroid/media/TimedTextEx$SetPenLocation;
    new-instance v5, Ljava/util/ArrayList;

    invoke-direct {v5}, Ljava/util/ArrayList;-><init>()V

    move-object/from16 v0, p0

    iput-object v5, v0, Landroid/media/TimedTextEx;->mSetPenLocation:Ljava/util/ArrayList;

    const/16 v28, 0x0

    .restart local v28    # "i":I
    :goto_19
    move-object/from16 v0, p0

    iget v5, v0, Landroid/media/TimedTextEx;->mLanguageCount:I

    move/from16 v0, v28

    if-ge v0, v5, :cond_1b

    move-object/from16 v0, p0

    iget-object v5, v0, Landroid/media/TimedTextEx;->mSetPenLocation:Ljava/util/ArrayList;

    move-object/from16 v0, v37

    invoke-virtual {v5, v0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    add-int/lit8 v28, v28, 0x1

    goto :goto_19

    .end local v28    # "i":I
    .end local v37    # "setPenLocation":Landroid/media/TimedTextEx$SetPenLocation;
    :cond_1b
    move-object/from16 v0, p0

    iget-object v5, v0, Landroid/media/TimedTextEx;->mDelay:Ljava/util/ArrayList;

    if-nez v5, :cond_1c

    new-instance v20, Landroid/media/TimedTextEx$Delay;

    const/4 v5, -0x1

    move-object/from16 v0, v20

    invoke-direct {v0, v5}, Landroid/media/TimedTextEx$Delay;-><init>(I)V

    .local v20, "d":Landroid/media/TimedTextEx$Delay;
    new-instance v5, Ljava/util/ArrayList;

    invoke-direct {v5}, Ljava/util/ArrayList;-><init>()V

    move-object/from16 v0, p0

    iput-object v5, v0, Landroid/media/TimedTextEx;->mDelay:Ljava/util/ArrayList;

    const/16 v28, 0x0

    .restart local v28    # "i":I
    :goto_1a
    move-object/from16 v0, p0

    iget v5, v0, Landroid/media/TimedTextEx;->mLanguageCount:I

    move/from16 v0, v28

    if-ge v0, v5, :cond_1c

    move-object/from16 v0, p0

    iget-object v5, v0, Landroid/media/TimedTextEx;->mDelay:Ljava/util/ArrayList;

    move-object/from16 v0, v20

    invoke-virtual {v5, v0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    add-int/lit8 v28, v28, 0x1

    goto :goto_1a

    .end local v20    # "d":Landroid/media/TimedTextEx$Delay;
    .end local v28    # "i":I
    :cond_1c
    move-object/from16 v0, p0

    iget-object v5, v0, Landroid/media/TimedTextEx;->mDelayCancel:Ljava/util/ArrayList;

    if-nez v5, :cond_1d

    new-instance v18, Landroid/media/TimedTextEx$DelayCancel;

    const/4 v5, -0x1

    move-object/from16 v0, v18

    invoke-direct {v0, v5}, Landroid/media/TimedTextEx$DelayCancel;-><init>(I)V

    .local v18, "cancel":Landroid/media/TimedTextEx$DelayCancel;
    new-instance v5, Ljava/util/ArrayList;

    invoke-direct {v5}, Ljava/util/ArrayList;-><init>()V

    move-object/from16 v0, p0

    iput-object v5, v0, Landroid/media/TimedTextEx;->mDelayCancel:Ljava/util/ArrayList;

    const/16 v28, 0x0

    .restart local v28    # "i":I
    :goto_1b
    move-object/from16 v0, p0

    iget v5, v0, Landroid/media/TimedTextEx;->mLanguageCount:I

    move/from16 v0, v28

    if-ge v0, v5, :cond_1d

    move-object/from16 v0, p0

    iget-object v5, v0, Landroid/media/TimedTextEx;->mDelayCancel:Ljava/util/ArrayList;

    move-object/from16 v0, v18

    invoke-virtual {v5, v0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    add-int/lit8 v28, v28, 0x1

    goto :goto_1b

    .end local v18    # "cancel":Landroid/media/TimedTextEx$DelayCancel;
    .end local v28    # "i":I
    :cond_1d
    move-object/from16 v0, p0

    iget-object v5, v0, Landroid/media/TimedTextEx;->mReset:Ljava/util/ArrayList;

    if-nez v5, :cond_1e

    new-instance v30, Landroid/media/TimedTextEx$Reset;

    const/4 v5, -0x1

    move-object/from16 v0, v30

    invoke-direct {v0, v5}, Landroid/media/TimedTextEx$Reset;-><init>(I)V

    .local v30, "r":Landroid/media/TimedTextEx$Reset;
    new-instance v5, Ljava/util/ArrayList;

    invoke-direct {v5}, Ljava/util/ArrayList;-><init>()V

    move-object/from16 v0, p0

    iput-object v5, v0, Landroid/media/TimedTextEx;->mReset:Ljava/util/ArrayList;

    const/16 v28, 0x0

    .restart local v28    # "i":I
    :goto_1c
    move-object/from16 v0, p0

    iget v5, v0, Landroid/media/TimedTextEx;->mLanguageCount:I

    move/from16 v0, v28

    if-ge v0, v5, :cond_1e

    move-object/from16 v0, p0

    iget-object v5, v0, Landroid/media/TimedTextEx;->mReset:Ljava/util/ArrayList;

    move-object/from16 v0, v30

    invoke-virtual {v5, v0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    add-int/lit8 v28, v28, 0x1

    goto :goto_1c

    .end local v28    # "i":I
    .end local v30    # "r":Landroid/media/TimedTextEx$Reset;
    :cond_1e
    move-object/from16 v0, p0

    iget-object v5, v0, Landroid/media/TimedTextEx;->mHorizontalCarriageReturn:Ljava/util/ArrayList;

    if-nez v5, :cond_1f

    new-instance v27, Landroid/media/TimedTextEx$HorizontalCarriageReturn;

    const/4 v5, -0x1

    move-object/from16 v0, v27

    invoke-direct {v0, v5}, Landroid/media/TimedTextEx$HorizontalCarriageReturn;-><init>(I)V

    .local v27, "horizontalCarriageReturn":Landroid/media/TimedTextEx$HorizontalCarriageReturn;
    new-instance v5, Ljava/util/ArrayList;

    invoke-direct {v5}, Ljava/util/ArrayList;-><init>()V

    move-object/from16 v0, p0

    iput-object v5, v0, Landroid/media/TimedTextEx;->mHorizontalCarriageReturn:Ljava/util/ArrayList;

    const/16 v28, 0x0

    .restart local v28    # "i":I
    :goto_1d
    move-object/from16 v0, p0

    iget v5, v0, Landroid/media/TimedTextEx;->mLanguageCount:I

    move/from16 v0, v28

    if-ge v0, v5, :cond_1f

    move-object/from16 v0, p0

    iget-object v5, v0, Landroid/media/TimedTextEx;->mHorizontalCarriageReturn:Ljava/util/ArrayList;

    move-object/from16 v0, v27

    invoke-virtual {v5, v0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    add-int/lit8 v28, v28, 0x1

    goto :goto_1d

    .end local v27    # "horizontalCarriageReturn":Landroid/media/TimedTextEx$HorizontalCarriageReturn;
    .end local v28    # "i":I
    :cond_1f
    move-object/from16 v0, p0

    iget-object v5, v0, Landroid/media/TimedTextEx;->mFormFeed:Ljava/util/ArrayList;

    if-nez v5, :cond_0

    new-instance v16, Landroid/media/TimedTextEx$FormFeed;

    const/4 v5, -0x1

    move-object/from16 v0, v16

    invoke-direct {v0, v5}, Landroid/media/TimedTextEx$FormFeed;-><init>(I)V

    .local v16, "FF":Landroid/media/TimedTextEx$FormFeed;
    new-instance v5, Ljava/util/ArrayList;

    invoke-direct {v5}, Ljava/util/ArrayList;-><init>()V

    move-object/from16 v0, p0

    iput-object v5, v0, Landroid/media/TimedTextEx;->mFormFeed:Ljava/util/ArrayList;

    const/16 v28, 0x0

    .restart local v28    # "i":I
    :goto_1e
    move-object/from16 v0, p0

    iget v5, v0, Landroid/media/TimedTextEx;->mLanguageCount:I

    move/from16 v0, v28

    if-ge v0, v5, :cond_0

    move-object/from16 v0, p0

    iget-object v5, v0, Landroid/media/TimedTextEx;->mFormFeed:Ljava/util/ArrayList;

    move-object/from16 v0, v16

    invoke-virtual {v5, v0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    add-int/lit8 v28, v28, 0x1

    goto :goto_1e
.end method

.method private isValidKey(I)Z
    .locals 3
    .param p1, "key"    # I

    .prologue
    const/4 v0, 0x1

    const-string v1, "TimedTextEx"

    const-string v2, "isValidKey"

    invoke-static {v1, v2}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    if-lt p1, v0, :cond_0

    const/16 v1, 0xe8

    if-le p1, v1, :cond_2

    :cond_0
    const/16 v1, 0x12d

    if-lt p1, v1, :cond_1

    const/16 v1, 0x192

    if-le p1, v1, :cond_2

    :cond_1
    const/4 v0, 0x0

    :cond_2
    return v0
.end method

.method private readCommand(Landroid/os/Parcel;)Z
    .locals 7
    .param p1, "parcel"    # Landroid/os/Parcel;

    .prologue
    const/4 v3, 0x1

    const/4 v1, 0x0

    .local v1, "key":I
    const/4 v0, 0x0

    .local v0, "dataPosition":I
    :cond_0
    :goto_0
    invoke-virtual {p1}, Landroid/os/Parcel;->dataAvail()I

    move-result v4

    if-lez v4, :cond_1

    invoke-virtual {p1}, Landroid/os/Parcel;->dataPosition()I

    move-result v0

    invoke-virtual {p1}, Landroid/os/Parcel;->readInt()I

    move-result v1

    invoke-direct {p0, v1}, Landroid/media/TimedTextEx;->isValidKey(I)Z

    move-result v4

    if-nez v4, :cond_2

    const-string v3, "TimedTextEx"

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "readCommand / Invalid timed text ex key found: "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    const/4 v3, 0x0

    :cond_1
    :goto_1
    return v3

    :cond_2
    const/16 v4, 0xc

    if-ne v1, v4, :cond_3

    const-string v4, "TimedTextEx"

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "readCommand / KEY_EX_MAX_SERVICE_NUM found: "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v5}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    invoke-virtual {p1, v0}, Landroid/os/Parcel;->setDataPosition(I)V

    goto :goto_1

    :cond_3
    const/4 v2, 0x0

    .local v2, "object":Ljava/lang/Object;
    sparse-switch v1, :sswitch_data_0

    .end local v2    # "object":Ljava/lang/Object;
    :goto_2
    if-eqz v2, :cond_0

    iget-object v4, p0, Landroid/media/TimedTextEx;->mKeyObjectMap:Ljava/util/HashMap;

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v5

    invoke-virtual {v4, v5}, Ljava/util/HashMap;->containsKey(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_4

    iget-object v4, p0, Landroid/media/TimedTextEx;->mKeyObjectMap:Ljava/util/HashMap;

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v5

    invoke-virtual {v4, v5}, Ljava/util/HashMap;->remove(Ljava/lang/Object;)Ljava/lang/Object;

    :cond_4
    iget-object v4, p0, Landroid/media/TimedTextEx;->mKeyObjectMap:Ljava/util/HashMap;

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v5

    invoke-virtual {v4, v5, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    goto :goto_0

    .restart local v2    # "object":Ljava/lang/Object;
    :sswitch_0
    invoke-direct {p0}, Landroid/media/TimedTextEx;->readCommand_EraseDisplayMemory()V

    iget-object v2, p0, Landroid/media/TimedTextEx;->mEraseDisMem:Ljava/util/ArrayList;

    .local v2, "object":Ljava/util/ArrayList;
    goto :goto_2

    .local v2, "object":Ljava/lang/Object;
    :sswitch_1
    invoke-direct {p0}, Landroid/media/TimedTextEx;->readCommand_ResumeCaptionLoading()V

    iget-object v2, p0, Landroid/media/TimedTextEx;->mResumeCaption:Ljava/util/ArrayList;

    .local v2, "object":Ljava/util/ArrayList;
    goto :goto_2

    .local v2, "object":Ljava/lang/Object;
    :sswitch_2
    invoke-direct {p0}, Landroid/media/TimedTextEx;->readCommand_EndOfCaption()V

    iget-object v2, p0, Landroid/media/TimedTextEx;->mEndofCaption:Ljava/util/ArrayList;

    .local v2, "object":Ljava/util/ArrayList;
    goto :goto_2

    .local v2, "object":Ljava/lang/Object;
    :sswitch_3
    invoke-direct {p0}, Landroid/media/TimedTextEx;->readCommand_TapOffset1()V

    iget-object v2, p0, Landroid/media/TimedTextEx;->mTapOffset1:Ljava/util/ArrayList;

    .local v2, "object":Ljava/util/ArrayList;
    goto :goto_2

    .local v2, "object":Ljava/lang/Object;
    :sswitch_4
    invoke-direct {p0}, Landroid/media/TimedTextEx;->readCommand_TapOffset2()V

    iget-object v2, p0, Landroid/media/TimedTextEx;->mTapOffset2:Ljava/util/ArrayList;

    .local v2, "object":Ljava/util/ArrayList;
    goto :goto_2

    .local v2, "object":Ljava/lang/Object;
    :sswitch_5
    invoke-direct {p0}, Landroid/media/TimedTextEx;->readCommand_TapOffset3()V

    iget-object v2, p0, Landroid/media/TimedTextEx;->mTapOffset3:Ljava/util/ArrayList;

    .local v2, "object":Ljava/util/ArrayList;
    goto :goto_2

    .local v2, "object":Ljava/lang/Object;
    :sswitch_6
    invoke-direct {p0}, Landroid/media/TimedTextEx;->readCommand_Rollup2()V

    iget-object v2, p0, Landroid/media/TimedTextEx;->mRollup2:Ljava/util/ArrayList;

    .local v2, "object":Ljava/util/ArrayList;
    goto :goto_2

    .local v2, "object":Ljava/lang/Object;
    :sswitch_7
    invoke-direct {p0}, Landroid/media/TimedTextEx;->readCommand_Rollup3()V

    iget-object v2, p0, Landroid/media/TimedTextEx;->mRollup3:Ljava/util/ArrayList;

    .local v2, "object":Ljava/util/ArrayList;
    goto :goto_2

    .local v2, "object":Ljava/lang/Object;
    :sswitch_8
    invoke-direct {p0}, Landroid/media/TimedTextEx;->readCommand_Rollup4()V

    iget-object v2, p0, Landroid/media/TimedTextEx;->mRollup4:Ljava/util/ArrayList;

    .local v2, "object":Ljava/util/ArrayList;
    goto :goto_2

    .local v2, "object":Ljava/lang/Object;
    :sswitch_9
    invoke-direct {p0}, Landroid/media/TimedTextEx;->readCommand_CarriageReturn()V

    iget-object v2, p0, Landroid/media/TimedTextEx;->mCR:Ljava/util/ArrayList;

    .local v2, "object":Ljava/util/ArrayList;
    goto :goto_2

    .local v2, "object":Ljava/lang/Object;
    :sswitch_a
    invoke-direct {p0}, Landroid/media/TimedTextEx;->readCommand_EraseNondisplayMemory()V

    iget-object v2, p0, Landroid/media/TimedTextEx;->mEraseNonDisMem:Ljava/util/ArrayList;

    .local v2, "object":Ljava/util/ArrayList;
    goto :goto_2

    .local v2, "object":Ljava/lang/Object;
    :sswitch_b
    invoke-direct {p0}, Landroid/media/TimedTextEx;->readCommand_Backspace()V

    iget-object v2, p0, Landroid/media/TimedTextEx;->mBackspace:Ljava/util/ArrayList;

    .local v2, "object":Ljava/util/ArrayList;
    goto :goto_2

    .local v2, "object":Ljava/lang/Object;
    :sswitch_c
    invoke-direct {p0}, Landroid/media/TimedTextEx;->readCommand_ResumeTextDisplay()V

    iget-object v2, p0, Landroid/media/TimedTextEx;->mResumeTextDis:Ljava/util/ArrayList;

    .local v2, "object":Ljava/util/ArrayList;
    goto :goto_2

    .local v2, "object":Ljava/lang/Object;
    :sswitch_d
    invoke-direct {p0, p1}, Landroid/media/TimedTextEx;->readCommand_PreambleAdressCode(Landroid/os/Parcel;)V

    iget-object v2, p0, Landroid/media/TimedTextEx;->mPreambleAdressCode:Ljava/util/ArrayList;

    .local v2, "object":Ljava/util/ArrayList;
    goto :goto_2

    .local v2, "object":Ljava/lang/Object;
    :sswitch_e
    invoke-direct {p0, p1}, Landroid/media/TimedTextEx;->readCommand_TextAttribute(Landroid/os/Parcel;)V

    iget-object v2, p0, Landroid/media/TimedTextEx;->mTextAttribute:Ljava/util/ArrayList;

    .local v2, "object":Ljava/util/ArrayList;
    goto :goto_2

    .local v2, "object":Ljava/lang/Object;
    :sswitch_f
    invoke-direct {p0, p1}, Landroid/media/TimedTextEx;->readCommand_SetCurrentWindow(Landroid/os/Parcel;)V

    iget-object v2, p0, Landroid/media/TimedTextEx;->mSetCurWin:Ljava/util/ArrayList;

    .local v2, "object":Ljava/util/ArrayList;
    goto :goto_2

    .local v2, "object":Ljava/lang/Object;
    :sswitch_10
    invoke-direct {p0, p1}, Landroid/media/TimedTextEx;->readCommand_ClearWindows(Landroid/os/Parcel;)V

    iget-object v2, p0, Landroid/media/TimedTextEx;->mClearWins:Ljava/util/ArrayList;

    .local v2, "object":Ljava/util/ArrayList;
    goto/16 :goto_2

    .local v2, "object":Ljava/lang/Object;
    :sswitch_11
    invoke-direct {p0, p1}, Landroid/media/TimedTextEx;->readCommand_DefineWindow(Landroid/os/Parcel;)V

    iget-object v2, p0, Landroid/media/TimedTextEx;->mDefineWin:Ljava/util/ArrayList;

    .local v2, "object":Ljava/util/ArrayList;
    goto/16 :goto_2

    .local v2, "object":Ljava/lang/Object;
    :sswitch_12
    invoke-direct {p0, p1}, Landroid/media/TimedTextEx;->readCommand_DeleteWindows(Landroid/os/Parcel;)V

    iget-object v2, p0, Landroid/media/TimedTextEx;->mDelWins:Ljava/util/ArrayList;

    .local v2, "object":Ljava/util/ArrayList;
    goto/16 :goto_2

    .local v2, "object":Ljava/lang/Object;
    :sswitch_13
    invoke-direct {p0, p1}, Landroid/media/TimedTextEx;->readCommand_DisplayWindows(Landroid/os/Parcel;)V

    iget-object v2, p0, Landroid/media/TimedTextEx;->mDisplayWins:Ljava/util/ArrayList;

    .local v2, "object":Ljava/util/ArrayList;
    goto/16 :goto_2

    .local v2, "object":Ljava/lang/Object;
    :sswitch_14
    invoke-direct {p0, p1}, Landroid/media/TimedTextEx;->readCommand_HideWindows(Landroid/os/Parcel;)V

    iget-object v2, p0, Landroid/media/TimedTextEx;->mHideWins:Ljava/util/ArrayList;

    .local v2, "object":Ljava/util/ArrayList;
    goto/16 :goto_2

    .local v2, "object":Ljava/lang/Object;
    :sswitch_15
    invoke-direct {p0, p1}, Landroid/media/TimedTextEx;->readCommand_ToggleWindows(Landroid/os/Parcel;)V

    iget-object v2, p0, Landroid/media/TimedTextEx;->mToggleWins:Ljava/util/ArrayList;

    .local v2, "object":Ljava/util/ArrayList;
    goto/16 :goto_2

    .local v2, "object":Ljava/lang/Object;
    :sswitch_16
    invoke-direct {p0, p1}, Landroid/media/TimedTextEx;->readCommand_SetWindowAttribute(Landroid/os/Parcel;)V

    iget-object v2, p0, Landroid/media/TimedTextEx;->mSetWinAttribute:Ljava/util/ArrayList;

    .local v2, "object":Ljava/util/ArrayList;
    goto/16 :goto_2

    .local v2, "object":Ljava/lang/Object;
    :sswitch_17
    invoke-direct {p0, p1}, Landroid/media/TimedTextEx;->readCommand_SetPenAttribute(Landroid/os/Parcel;)V

    iget-object v2, p0, Landroid/media/TimedTextEx;->mSetPenAttribute:Ljava/util/ArrayList;

    .local v2, "object":Ljava/util/ArrayList;
    goto/16 :goto_2

    .local v2, "object":Ljava/lang/Object;
    :sswitch_18
    invoke-direct {p0, p1}, Landroid/media/TimedTextEx;->readCommand_SetPenColor(Landroid/os/Parcel;)V

    iget-object v2, p0, Landroid/media/TimedTextEx;->mSetPenColor:Ljava/util/ArrayList;

    .local v2, "object":Ljava/util/ArrayList;
    goto/16 :goto_2

    .local v2, "object":Ljava/lang/Object;
    :sswitch_19
    invoke-direct {p0, p1}, Landroid/media/TimedTextEx;->readCommand_SetPenLocation(Landroid/os/Parcel;)V

    iget-object v2, p0, Landroid/media/TimedTextEx;->mSetPenLocation:Ljava/util/ArrayList;

    .local v2, "object":Ljava/util/ArrayList;
    goto/16 :goto_2

    .local v2, "object":Ljava/lang/Object;
    :sswitch_1a
    invoke-direct {p0, p1}, Landroid/media/TimedTextEx;->readCommand_Delay(Landroid/os/Parcel;)V

    iget-object v2, p0, Landroid/media/TimedTextEx;->mDelay:Ljava/util/ArrayList;

    .local v2, "object":Ljava/util/ArrayList;
    goto/16 :goto_2

    .local v2, "object":Ljava/lang/Object;
    :sswitch_1b
    invoke-direct {p0}, Landroid/media/TimedTextEx;->readCommand_DelayCancel()V

    iget-object v2, p0, Landroid/media/TimedTextEx;->mDelayCancel:Ljava/util/ArrayList;

    .local v2, "object":Ljava/util/ArrayList;
    goto/16 :goto_2

    .local v2, "object":Ljava/lang/Object;
    :sswitch_1c
    invoke-direct {p0}, Landroid/media/TimedTextEx;->readCommand_Reset()V

    iget-object v2, p0, Landroid/media/TimedTextEx;->mReset:Ljava/util/ArrayList;

    .local v2, "object":Ljava/util/ArrayList;
    goto/16 :goto_2

    .local v2, "object":Ljava/lang/Object;
    :sswitch_1d
    invoke-direct {p0}, Landroid/media/TimedTextEx;->readCommand_HorizontalCarriageReturn()V

    iget-object v2, p0, Landroid/media/TimedTextEx;->mHorizontalCarriageReturn:Ljava/util/ArrayList;

    .local v2, "object":Ljava/util/ArrayList;
    goto/16 :goto_2

    .local v2, "object":Ljava/lang/Object;
    :sswitch_1e
    invoke-direct {p0}, Landroid/media/TimedTextEx;->readCommand_FormFeed()V

    iget-object v2, p0, Landroid/media/TimedTextEx;->mFormFeed:Ljava/util/ArrayList;

    .local v2, "object":Ljava/util/ArrayList;
    goto/16 :goto_2

    nop

    :sswitch_data_0
    .sparse-switch
        0x65 -> :sswitch_0
        0x66 -> :sswitch_1
        0x67 -> :sswitch_2
        0x68 -> :sswitch_3
        0x69 -> :sswitch_4
        0x6a -> :sswitch_5
        0x6b -> :sswitch_6
        0x6c -> :sswitch_7
        0x6d -> :sswitch_8
        0x6e -> :sswitch_9
        0x6f -> :sswitch_a
        0x70 -> :sswitch_b
        0x71 -> :sswitch_c
        0x72 -> :sswitch_d
        0x73 -> :sswitch_e
        0xc9 -> :sswitch_f
        0xca -> :sswitch_10
        0xcb -> :sswitch_11
        0xcc -> :sswitch_12
        0xcd -> :sswitch_13
        0xce -> :sswitch_14
        0xcf -> :sswitch_15
        0xd0 -> :sswitch_16
        0xd3 -> :sswitch_17
        0xd4 -> :sswitch_18
        0xd5 -> :sswitch_19
        0xdd -> :sswitch_1a
        0xde -> :sswitch_1b
        0xdf -> :sswitch_1c
        0xe7 -> :sswitch_1d
        0xe8 -> :sswitch_1e
    .end sparse-switch
.end method

.method private readCommand_Backspace()V
    .locals 4

    .prologue
    const-string v2, "TimedTextEx"

    const-string v3, "readCommand_Backspace"

    invoke-static {v2, v3}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    const/4 v1, 0x1

    .local v1, "backspace":I
    new-instance v0, Landroid/media/TimedTextEx$Backspace;

    invoke-direct {v0, v1}, Landroid/media/TimedTextEx$Backspace;-><init>(I)V

    .local v0, "backSpace":Landroid/media/TimedTextEx$Backspace;
    iget-object v2, p0, Landroid/media/TimedTextEx;->mBackspace:Ljava/util/ArrayList;

    iget v3, p0, Landroid/media/TimedTextEx;->mIndex:I

    invoke-virtual {v2, v3, v0}, Ljava/util/ArrayList;->set(ILjava/lang/Object;)Ljava/lang/Object;

    return-void
.end method

.method private readCommand_CarriageReturn()V
    .locals 4

    .prologue
    const-string v2, "TimedTextEx"

    const-string v3, "readCommand_CarriageReturn"

    invoke-static {v2, v3}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    const/4 v1, 0x1

    .local v1, "cr":I
    new-instance v0, Landroid/media/TimedTextEx$CarriageReturn;

    invoke-direct {v0, v1}, Landroid/media/TimedTextEx$CarriageReturn;-><init>(I)V

    .local v0, "CR":Landroid/media/TimedTextEx$CarriageReturn;
    iget-object v2, p0, Landroid/media/TimedTextEx;->mCR:Ljava/util/ArrayList;

    iget v3, p0, Landroid/media/TimedTextEx;->mIndex:I

    invoke-virtual {v2, v3, v0}, Ljava/util/ArrayList;->set(ILjava/lang/Object;)Ljava/lang/Object;

    return-void
.end method

.method private readCommand_ClearWindows(Landroid/os/Parcel;)V
    .locals 4
    .param p1, "parcel"    # Landroid/os/Parcel;

    .prologue
    const-string v2, "TimedTextEx"

    const-string v3, "readCommand_ClearWindows"

    invoke-static {v2, v3}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    invoke-virtual {p1}, Landroid/os/Parcel;->readInt()I

    move-result v1

    .local v1, "windowMap":I
    new-instance v0, Landroid/media/TimedTextEx$ClearWindows;

    invoke-direct {v0, v1}, Landroid/media/TimedTextEx$ClearWindows;-><init>(I)V

    .local v0, "clearWins":Landroid/media/TimedTextEx$ClearWindows;
    iget-object v2, p0, Landroid/media/TimedTextEx;->mClearWins:Ljava/util/ArrayList;

    iget v3, p0, Landroid/media/TimedTextEx;->mIndex:I

    invoke-virtual {v2, v3, v0}, Ljava/util/ArrayList;->set(ILjava/lang/Object;)Ljava/lang/Object;

    return-void
.end method

.method private readCommand_DefineWindow(Landroid/os/Parcel;)V
    .locals 17
    .param p1, "parcel"    # Landroid/os/Parcel;

    .prologue
    const-string v15, "TimedTextEx"

    const-string v16, "readCommand_DefineWindow"

    invoke-static/range {v15 .. v16}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    invoke-virtual/range {p1 .. p1}, Landroid/os/Parcel;->readInt()I

    move-result v2

    .local v2, "windowID":I
    invoke-virtual/range {p1 .. p1}, Landroid/os/Parcel;->readInt()I

    move-result v3

    .local v3, "priority":I
    invoke-virtual/range {p1 .. p1}, Landroid/os/Parcel;->readInt()I

    move-result v4

    .local v4, "anchorPoint":I
    invoke-virtual/range {p1 .. p1}, Landroid/os/Parcel;->readInt()I

    move-result v5

    .local v5, "relativePosition":I
    invoke-virtual/range {p1 .. p1}, Landroid/os/Parcel;->readInt()I

    move-result v6

    .local v6, "anchorVertical":I
    invoke-virtual/range {p1 .. p1}, Landroid/os/Parcel;->readInt()I

    move-result v7

    .local v7, "anchorHorizontal":I
    invoke-virtual/range {p1 .. p1}, Landroid/os/Parcel;->readInt()I

    move-result v8

    .local v8, "rowCount":I
    invoke-virtual/range {p1 .. p1}, Landroid/os/Parcel;->readInt()I

    move-result v9

    .local v9, "columnCount":I
    invoke-virtual/range {p1 .. p1}, Landroid/os/Parcel;->readInt()I

    move-result v10

    .local v10, "rowLock":I
    invoke-virtual/range {p1 .. p1}, Landroid/os/Parcel;->readInt()I

    move-result v11

    .local v11, "columnLock":I
    invoke-virtual/range {p1 .. p1}, Landroid/os/Parcel;->readInt()I

    move-result v12

    .local v12, "visible":I
    invoke-virtual/range {p1 .. p1}, Landroid/os/Parcel;->readInt()I

    move-result v13

    .local v13, "windowStyleID":I
    invoke-virtual/range {p1 .. p1}, Landroid/os/Parcel;->readInt()I

    move-result v14

    .local v14, "penStyleID":I
    new-instance v1, Landroid/media/TimedTextEx$DefineWindow;

    invoke-direct/range {v1 .. v14}, Landroid/media/TimedTextEx$DefineWindow;-><init>(IIIIIIIIIIIII)V

    .local v1, "defineWin":Landroid/media/TimedTextEx$DefineWindow;
    move-object/from16 v0, p0

    iget-object v15, v0, Landroid/media/TimedTextEx;->mDefineWin:Ljava/util/ArrayList;

    move-object/from16 v0, p0

    iget v0, v0, Landroid/media/TimedTextEx;->mIndex:I

    move/from16 v16, v0

    move/from16 v0, v16

    invoke-virtual {v15, v0, v1}, Ljava/util/ArrayList;->set(ILjava/lang/Object;)Ljava/lang/Object;

    return-void
.end method

.method private readCommand_Delay(Landroid/os/Parcel;)V
    .locals 4
    .param p1, "parcel"    # Landroid/os/Parcel;

    .prologue
    const-string v2, "TimedTextEx"

    const-string v3, "readCommand_Delay"

    invoke-static {v2, v3}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    invoke-virtual {p1}, Landroid/os/Parcel;->readInt()I

    move-result v1

    .local v1, "delay":I
    new-instance v0, Landroid/media/TimedTextEx$Delay;

    invoke-direct {v0, v1}, Landroid/media/TimedTextEx$Delay;-><init>(I)V

    .local v0, "d":Landroid/media/TimedTextEx$Delay;
    iget-object v2, p0, Landroid/media/TimedTextEx;->mDelay:Ljava/util/ArrayList;

    iget v3, p0, Landroid/media/TimedTextEx;->mIndex:I

    invoke-virtual {v2, v3, v0}, Ljava/util/ArrayList;->set(ILjava/lang/Object;)Ljava/lang/Object;

    return-void
.end method

.method private readCommand_DelayCancel()V
    .locals 4

    .prologue
    const-string v2, "TimedTextEx"

    const-string v3, "readCommand_DelayCancel"

    invoke-static {v2, v3}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    const/4 v1, 0x1

    .local v1, "delayCancel":I
    new-instance v0, Landroid/media/TimedTextEx$DelayCancel;

    invoke-direct {v0, v1}, Landroid/media/TimedTextEx$DelayCancel;-><init>(I)V

    .local v0, "cancel":Landroid/media/TimedTextEx$DelayCancel;
    iget-object v2, p0, Landroid/media/TimedTextEx;->mDelayCancel:Ljava/util/ArrayList;

    iget v3, p0, Landroid/media/TimedTextEx;->mIndex:I

    invoke-virtual {v2, v3, v0}, Ljava/util/ArrayList;->set(ILjava/lang/Object;)Ljava/lang/Object;

    return-void
.end method

.method private readCommand_DeleteWindows(Landroid/os/Parcel;)V
    .locals 4
    .param p1, "parcel"    # Landroid/os/Parcel;

    .prologue
    const-string v2, "TimedTextEx"

    const-string v3, "readCommand_DeleteWindows"

    invoke-static {v2, v3}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    invoke-virtual {p1}, Landroid/os/Parcel;->readInt()I

    move-result v1

    .local v1, "windowMap":I
    new-instance v0, Landroid/media/TimedTextEx$DeleteWindows;

    invoke-direct {v0, v1}, Landroid/media/TimedTextEx$DeleteWindows;-><init>(I)V

    .local v0, "delWins":Landroid/media/TimedTextEx$DeleteWindows;
    iget-object v2, p0, Landroid/media/TimedTextEx;->mDelWins:Ljava/util/ArrayList;

    iget v3, p0, Landroid/media/TimedTextEx;->mIndex:I

    invoke-virtual {v2, v3, v0}, Ljava/util/ArrayList;->set(ILjava/lang/Object;)Ljava/lang/Object;

    return-void
.end method

.method private readCommand_DisplayWindows(Landroid/os/Parcel;)V
    .locals 4
    .param p1, "parcel"    # Landroid/os/Parcel;

    .prologue
    const-string v2, "TimedTextEx"

    const-string v3, "readCommand_DisplayWindows"

    invoke-static {v2, v3}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    invoke-virtual {p1}, Landroid/os/Parcel;->readInt()I

    move-result v1

    .local v1, "windowMap":I
    new-instance v0, Landroid/media/TimedTextEx$DisplayWindows;

    invoke-direct {v0, v1}, Landroid/media/TimedTextEx$DisplayWindows;-><init>(I)V

    .local v0, "displayWins":Landroid/media/TimedTextEx$DisplayWindows;
    iget-object v2, p0, Landroid/media/TimedTextEx;->mDisplayWins:Ljava/util/ArrayList;

    iget v3, p0, Landroid/media/TimedTextEx;->mIndex:I

    invoke-virtual {v2, v3, v0}, Ljava/util/ArrayList;->set(ILjava/lang/Object;)Ljava/lang/Object;

    return-void
.end method

.method private readCommand_EndOfCaption()V
    .locals 4

    .prologue
    const-string v2, "TimedTextEx"

    const-string v3, "readCommand_EndOfCaption"

    invoke-static {v2, v3}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    const/4 v0, 0x1

    .local v0, "end":I
    new-instance v1, Landroid/media/TimedTextEx$EndOfCaption;

    invoke-direct {v1, v0}, Landroid/media/TimedTextEx$EndOfCaption;-><init>(I)V

    .local v1, "endofCaption":Landroid/media/TimedTextEx$EndOfCaption;
    iget-object v2, p0, Landroid/media/TimedTextEx;->mEndofCaption:Ljava/util/ArrayList;

    iget v3, p0, Landroid/media/TimedTextEx;->mIndex:I

    invoke-virtual {v2, v3, v1}, Ljava/util/ArrayList;->set(ILjava/lang/Object;)Ljava/lang/Object;

    return-void
.end method

.method private readCommand_EraseDisplayMemory()V
    .locals 4

    .prologue
    const-string v2, "TimedTextEx"

    const-string v3, "readCommand_EraseDisplayMemory"

    invoke-static {v2, v3}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    const/4 v0, 0x1

    .local v0, "erase":I
    new-instance v1, Landroid/media/TimedTextEx$EraseDisplayMemory;

    invoke-direct {v1, v0}, Landroid/media/TimedTextEx$EraseDisplayMemory;-><init>(I)V

    .local v1, "eraseDisMem":Landroid/media/TimedTextEx$EraseDisplayMemory;
    iget-object v2, p0, Landroid/media/TimedTextEx;->mEraseDisMem:Ljava/util/ArrayList;

    iget v3, p0, Landroid/media/TimedTextEx;->mIndex:I

    invoke-virtual {v2, v3, v1}, Ljava/util/ArrayList;->set(ILjava/lang/Object;)Ljava/lang/Object;

    return-void
.end method

.method private readCommand_EraseNondisplayMemory()V
    .locals 4

    .prologue
    const-string v2, "TimedTextEx"

    const-string v3, "readCommand_EraseNondisplayMemory"

    invoke-static {v2, v3}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    const/4 v0, 0x1

    .local v0, "erase":I
    new-instance v1, Landroid/media/TimedTextEx$EraseNondisplayMemory;

    invoke-direct {v1, v0}, Landroid/media/TimedTextEx$EraseNondisplayMemory;-><init>(I)V

    .local v1, "eraseNonDisMem":Landroid/media/TimedTextEx$EraseNondisplayMemory;
    iget-object v2, p0, Landroid/media/TimedTextEx;->mEraseNonDisMem:Ljava/util/ArrayList;

    iget v3, p0, Landroid/media/TimedTextEx;->mIndex:I

    invoke-virtual {v2, v3, v1}, Ljava/util/ArrayList;->set(ILjava/lang/Object;)Ljava/lang/Object;

    return-void
.end method

.method private readCommand_FormFeed()V
    .locals 4

    .prologue
    const-string v2, "TimedTextEx"

    const-string v3, "readCommand_FormFeed"

    invoke-static {v2, v3}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    const/4 v1, 0x1

    .local v1, "formFeed":I
    new-instance v0, Landroid/media/TimedTextEx$FormFeed;

    invoke-direct {v0, v1}, Landroid/media/TimedTextEx$FormFeed;-><init>(I)V

    .local v0, "FF":Landroid/media/TimedTextEx$FormFeed;
    iget-object v2, p0, Landroid/media/TimedTextEx;->mFormFeed:Ljava/util/ArrayList;

    iget v3, p0, Landroid/media/TimedTextEx;->mIndex:I

    invoke-virtual {v2, v3, v0}, Ljava/util/ArrayList;->set(ILjava/lang/Object;)Ljava/lang/Object;

    return-void
.end method

.method private readCommand_HideWindows(Landroid/os/Parcel;)V
    .locals 4
    .param p1, "parcel"    # Landroid/os/Parcel;

    .prologue
    const-string v2, "TimedTextEx"

    const-string v3, "readCommand_HideWindows"

    invoke-static {v2, v3}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    invoke-virtual {p1}, Landroid/os/Parcel;->readInt()I

    move-result v1

    .local v1, "windowMap":I
    new-instance v0, Landroid/media/TimedTextEx$HideWindows;

    invoke-direct {v0, v1}, Landroid/media/TimedTextEx$HideWindows;-><init>(I)V

    .local v0, "hideWins":Landroid/media/TimedTextEx$HideWindows;
    iget-object v2, p0, Landroid/media/TimedTextEx;->mHideWins:Ljava/util/ArrayList;

    iget v3, p0, Landroid/media/TimedTextEx;->mIndex:I

    invoke-virtual {v2, v3, v0}, Ljava/util/ArrayList;->set(ILjava/lang/Object;)Ljava/lang/Object;

    return-void
.end method

.method private readCommand_HorizontalCarriageReturn()V
    .locals 4

    .prologue
    const-string v2, "TimedTextEx"

    const-string v3, "readCommand_HorizontalCarriageReturn"

    invoke-static {v2, v3}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    const/4 v0, 0x1

    .local v0, "hcr":I
    new-instance v1, Landroid/media/TimedTextEx$HorizontalCarriageReturn;

    invoke-direct {v1, v0}, Landroid/media/TimedTextEx$HorizontalCarriageReturn;-><init>(I)V

    .local v1, "horizontalCarriageReturn":Landroid/media/TimedTextEx$HorizontalCarriageReturn;
    iget-object v2, p0, Landroid/media/TimedTextEx;->mHorizontalCarriageReturn:Ljava/util/ArrayList;

    iget v3, p0, Landroid/media/TimedTextEx;->mIndex:I

    invoke-virtual {v2, v3, v1}, Ljava/util/ArrayList;->set(ILjava/lang/Object;)Ljava/lang/Object;

    return-void
.end method

.method private readCommand_PreambleAdressCode(Landroid/os/Parcel;)V
    .locals 7
    .param p1, "parcel"    # Landroid/os/Parcel;

    .prologue
    const-string v5, "TimedTextEx"

    const-string v6, "readCommand_PreambleAdressCode"

    invoke-static {v5, v6}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    invoke-virtual {p1}, Landroid/os/Parcel;->readInt()I

    move-result v4

    .local v4, "row":I
    invoke-virtual {p1}, Landroid/os/Parcel;->readInt()I

    move-result v0

    .local v0, "color":I
    invoke-virtual {p1}, Landroid/os/Parcel;->readInt()I

    move-result v1

    .local v1, "font":I
    invoke-virtual {p1}, Landroid/os/Parcel;->readInt()I

    move-result v2

    .local v2, "indent":I
    new-instance v3, Landroid/media/TimedTextEx$PreambleAdressCode;

    invoke-direct {v3, v4, v0, v1, v2}, Landroid/media/TimedTextEx$PreambleAdressCode;-><init>(IIII)V

    .local v3, "preambleAdressCode":Landroid/media/TimedTextEx$PreambleAdressCode;
    iget-object v5, p0, Landroid/media/TimedTextEx;->mPreambleAdressCode:Ljava/util/ArrayList;

    iget v6, p0, Landroid/media/TimedTextEx;->mIndex:I

    invoke-virtual {v5, v6, v3}, Ljava/util/ArrayList;->set(ILjava/lang/Object;)Ljava/lang/Object;

    return-void
.end method

.method private readCommand_Reset()V
    .locals 4

    .prologue
    const-string v2, "TimedTextEx"

    const-string v3, "readCommand_Reset"

    invoke-static {v2, v3}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    const/4 v1, 0x1

    .local v1, "reset":I
    new-instance v0, Landroid/media/TimedTextEx$Reset;

    invoke-direct {v0, v1}, Landroid/media/TimedTextEx$Reset;-><init>(I)V

    .local v0, "r":Landroid/media/TimedTextEx$Reset;
    iget-object v2, p0, Landroid/media/TimedTextEx;->mReset:Ljava/util/ArrayList;

    iget v3, p0, Landroid/media/TimedTextEx;->mIndex:I

    invoke-virtual {v2, v3, v0}, Ljava/util/ArrayList;->set(ILjava/lang/Object;)Ljava/lang/Object;

    return-void
.end method

.method private readCommand_ResumeCaptionLoading()V
    .locals 4

    .prologue
    const-string v2, "TimedTextEx"

    const-string v3, "readCommand_ResumeCaptionLoading"

    invoke-static {v2, v3}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    const/4 v0, 0x1

    .local v0, "resume":I
    new-instance v1, Landroid/media/TimedTextEx$ResumeCaptionLoading;

    invoke-direct {v1, v0}, Landroid/media/TimedTextEx$ResumeCaptionLoading;-><init>(I)V

    .local v1, "resumeCaption":Landroid/media/TimedTextEx$ResumeCaptionLoading;
    iget-object v2, p0, Landroid/media/TimedTextEx;->mResumeCaption:Ljava/util/ArrayList;

    iget v3, p0, Landroid/media/TimedTextEx;->mIndex:I

    invoke-virtual {v2, v3, v1}, Ljava/util/ArrayList;->set(ILjava/lang/Object;)Ljava/lang/Object;

    return-void
.end method

.method private readCommand_ResumeTextDisplay()V
    .locals 4

    .prologue
    const-string v2, "TimedTextEx"

    const-string v3, "readCommand_ResumeTextDisplay"

    invoke-static {v2, v3}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    const/4 v0, 0x1

    .local v0, "resume":I
    new-instance v1, Landroid/media/TimedTextEx$ResumeTextDisplay;

    invoke-direct {v1, v0}, Landroid/media/TimedTextEx$ResumeTextDisplay;-><init>(I)V

    .local v1, "resumeTextDis":Landroid/media/TimedTextEx$ResumeTextDisplay;
    iget-object v2, p0, Landroid/media/TimedTextEx;->mResumeTextDis:Ljava/util/ArrayList;

    iget v3, p0, Landroid/media/TimedTextEx;->mIndex:I

    invoke-virtual {v2, v3, v1}, Ljava/util/ArrayList;->set(ILjava/lang/Object;)Ljava/lang/Object;

    return-void
.end method

.method private readCommand_Rollup2()V
    .locals 4

    .prologue
    const-string v2, "TimedTextEx"

    const-string v3, "readCommand_Rollup2"

    invoke-static {v2, v3}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    const/4 v0, 0x1

    .local v0, "rollup":I
    new-instance v1, Landroid/media/TimedTextEx$Rollup2;

    invoke-direct {v1, v0}, Landroid/media/TimedTextEx$Rollup2;-><init>(I)V

    .local v1, "rollup2":Landroid/media/TimedTextEx$Rollup2;
    iget-object v2, p0, Landroid/media/TimedTextEx;->mRollup2:Ljava/util/ArrayList;

    iget v3, p0, Landroid/media/TimedTextEx;->mIndex:I

    invoke-virtual {v2, v3, v1}, Ljava/util/ArrayList;->set(ILjava/lang/Object;)Ljava/lang/Object;

    return-void
.end method

.method private readCommand_Rollup3()V
    .locals 4

    .prologue
    const-string v2, "TimedTextEx"

    const-string v3, "readCommand_Rollup3"

    invoke-static {v2, v3}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    const/4 v0, 0x1

    .local v0, "rollup":I
    new-instance v1, Landroid/media/TimedTextEx$Rollup3;

    invoke-direct {v1, v0}, Landroid/media/TimedTextEx$Rollup3;-><init>(I)V

    .local v1, "rollup3":Landroid/media/TimedTextEx$Rollup3;
    iget-object v2, p0, Landroid/media/TimedTextEx;->mRollup3:Ljava/util/ArrayList;

    iget v3, p0, Landroid/media/TimedTextEx;->mIndex:I

    invoke-virtual {v2, v3, v1}, Ljava/util/ArrayList;->set(ILjava/lang/Object;)Ljava/lang/Object;

    return-void
.end method

.method private readCommand_Rollup4()V
    .locals 4

    .prologue
    const-string v2, "TimedTextEx"

    const-string v3, "readCommand_Rollup4"

    invoke-static {v2, v3}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    const/4 v0, 0x1

    .local v0, "rollup":I
    new-instance v1, Landroid/media/TimedTextEx$Rollup4;

    invoke-direct {v1, v0}, Landroid/media/TimedTextEx$Rollup4;-><init>(I)V

    .local v1, "rollup4":Landroid/media/TimedTextEx$Rollup4;
    iget-object v2, p0, Landroid/media/TimedTextEx;->mRollup4:Ljava/util/ArrayList;

    iget v3, p0, Landroid/media/TimedTextEx;->mIndex:I

    invoke-virtual {v2, v3, v1}, Ljava/util/ArrayList;->set(ILjava/lang/Object;)Ljava/lang/Object;

    return-void
.end method

.method private readCommand_SetCurrentWindow(Landroid/os/Parcel;)V
    .locals 4
    .param p1, "parcel"    # Landroid/os/Parcel;

    .prologue
    const-string v2, "TimedTextEx"

    const-string v3, "readCommand_SetCurrentWindow"

    invoke-static {v2, v3}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    invoke-virtual {p1}, Landroid/os/Parcel;->readInt()I

    move-result v1

    .local v1, "windowID":I
    new-instance v0, Landroid/media/TimedTextEx$SetCurrentWindow;

    invoke-direct {v0, v1}, Landroid/media/TimedTextEx$SetCurrentWindow;-><init>(I)V

    .local v0, "setCurWin":Landroid/media/TimedTextEx$SetCurrentWindow;
    iget-object v2, p0, Landroid/media/TimedTextEx;->mSetCurWin:Ljava/util/ArrayList;

    iget v3, p0, Landroid/media/TimedTextEx;->mIndex:I

    invoke-virtual {v2, v3, v0}, Ljava/util/ArrayList;->set(ILjava/lang/Object;)Ljava/lang/Object;

    return-void
.end method

.method private readCommand_SetPenAttribute(Landroid/os/Parcel;)V
    .locals 10
    .param p1, "parcel"    # Landroid/os/Parcel;

    .prologue
    const-string v8, "TimedTextEx"

    const-string v9, "readCommand_SetPenAttribute"

    invoke-static {v8, v9}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    invoke-virtual {p1}, Landroid/os/Parcel;->readInt()I

    move-result v1

    .local v1, "penSize":I
    invoke-virtual {p1}, Landroid/os/Parcel;->readInt()I

    move-result v2

    .local v2, "font":I
    invoke-virtual {p1}, Landroid/os/Parcel;->readInt()I

    move-result v3

    .local v3, "textTag":I
    invoke-virtual {p1}, Landroid/os/Parcel;->readInt()I

    move-result v4

    .local v4, "offSet":I
    invoke-virtual {p1}, Landroid/os/Parcel;->readInt()I

    move-result v5

    .local v5, "italics":I
    invoke-virtual {p1}, Landroid/os/Parcel;->readInt()I

    move-result v6

    .local v6, "underline":I
    invoke-virtual {p1}, Landroid/os/Parcel;->readInt()I

    move-result v7

    .local v7, "edgeType":I
    new-instance v0, Landroid/media/TimedTextEx$SetPenAttribute;

    invoke-direct/range {v0 .. v7}, Landroid/media/TimedTextEx$SetPenAttribute;-><init>(IIIIIII)V

    .local v0, "setPenAttribute":Landroid/media/TimedTextEx$SetPenAttribute;
    iget-object v8, p0, Landroid/media/TimedTextEx;->mSetPenAttribute:Ljava/util/ArrayList;

    iget v9, p0, Landroid/media/TimedTextEx;->mIndex:I

    invoke-virtual {v8, v9, v0}, Ljava/util/ArrayList;->set(ILjava/lang/Object;)Ljava/lang/Object;

    return-void
.end method

.method private readCommand_SetPenColor(Landroid/os/Parcel;)V
    .locals 8
    .param p1, "parcel"    # Landroid/os/Parcel;

    .prologue
    const-string v6, "TimedTextEx"

    const-string v7, "readCommand_SetPenColor"

    invoke-static {v6, v7}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    invoke-virtual {p1}, Landroid/os/Parcel;->readInt()I

    move-result v1

    .local v1, "fgColor":I
    invoke-virtual {p1}, Landroid/os/Parcel;->readInt()I

    move-result v2

    .local v2, "fgOpacity":I
    invoke-virtual {p1}, Landroid/os/Parcel;->readInt()I

    move-result v3

    .local v3, "bgColor":I
    invoke-virtual {p1}, Landroid/os/Parcel;->readInt()I

    move-result v4

    .local v4, "bgOpacity":I
    invoke-virtual {p1}, Landroid/os/Parcel;->readInt()I

    move-result v5

    .local v5, "egdeColor":I
    new-instance v0, Landroid/media/TimedTextEx$SetPenColor;

    invoke-direct/range {v0 .. v5}, Landroid/media/TimedTextEx$SetPenColor;-><init>(IIIII)V

    .local v0, "setPenColor":Landroid/media/TimedTextEx$SetPenColor;
    iget-object v6, p0, Landroid/media/TimedTextEx;->mSetPenColor:Ljava/util/ArrayList;

    iget v7, p0, Landroid/media/TimedTextEx;->mIndex:I

    invoke-virtual {v6, v7, v0}, Ljava/util/ArrayList;->set(ILjava/lang/Object;)Ljava/lang/Object;

    return-void
.end method

.method private readCommand_SetPenLocation(Landroid/os/Parcel;)V
    .locals 5
    .param p1, "parcel"    # Landroid/os/Parcel;

    .prologue
    const-string v3, "TimedTextEx"

    const-string v4, "readCommand_SetPenLocation"

    invoke-static {v3, v4}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    invoke-virtual {p1}, Landroid/os/Parcel;->readInt()I

    move-result v1

    .local v1, "row":I
    invoke-virtual {p1}, Landroid/os/Parcel;->readInt()I

    move-result v0

    .local v0, "column":I
    new-instance v2, Landroid/media/TimedTextEx$SetPenLocation;

    invoke-direct {v2, v1, v0}, Landroid/media/TimedTextEx$SetPenLocation;-><init>(II)V

    .local v2, "setPenLocation":Landroid/media/TimedTextEx$SetPenLocation;
    iget-object v3, p0, Landroid/media/TimedTextEx;->mSetPenLocation:Ljava/util/ArrayList;

    iget v4, p0, Landroid/media/TimedTextEx;->mIndex:I

    invoke-virtual {v3, v4, v2}, Ljava/util/ArrayList;->set(ILjava/lang/Object;)Ljava/lang/Object;

    return-void
.end method

.method private readCommand_SetWindowAttribute(Landroid/os/Parcel;)V
    .locals 14
    .param p1, "parcel"    # Landroid/os/Parcel;

    .prologue
    const-string v12, "TimedTextEx"

    const-string v13, "readCommand_SetWindowAttribute"

    invoke-static {v12, v13}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    invoke-virtual {p1}, Landroid/os/Parcel;->readInt()I

    move-result v1

    .local v1, "justify":I
    invoke-virtual {p1}, Landroid/os/Parcel;->readInt()I

    move-result v2

    .local v2, "printDirection":I
    invoke-virtual {p1}, Landroid/os/Parcel;->readInt()I

    move-result v3

    .local v3, "scrollDirection":I
    invoke-virtual {p1}, Landroid/os/Parcel;->readInt()I

    move-result v4

    .local v4, "wordRap":I
    invoke-virtual {p1}, Landroid/os/Parcel;->readInt()I

    move-result v5

    .local v5, "displayEffect":I
    invoke-virtual {p1}, Landroid/os/Parcel;->readInt()I

    move-result v6

    .local v6, "effectDirection":I
    invoke-virtual {p1}, Landroid/os/Parcel;->readInt()I

    move-result v7

    .local v7, "effectSpeed":I
    invoke-virtual {p1}, Landroid/os/Parcel;->readInt()I

    move-result v8

    .local v8, "fillColor":I
    invoke-virtual {p1}, Landroid/os/Parcel;->readInt()I

    move-result v9

    .local v9, "fillOpacity":I
    invoke-virtual {p1}, Landroid/os/Parcel;->readInt()I

    move-result v10

    .local v10, "borderType":I
    invoke-virtual {p1}, Landroid/os/Parcel;->readInt()I

    move-result v11

    .local v11, "borderColor":I
    new-instance v0, Landroid/media/TimedTextEx$SetWindowAttribute;

    invoke-direct/range {v0 .. v11}, Landroid/media/TimedTextEx$SetWindowAttribute;-><init>(IIIIIIIIIII)V

    .local v0, "setWinAttribute":Landroid/media/TimedTextEx$SetWindowAttribute;
    iget-object v12, p0, Landroid/media/TimedTextEx;->mSetWinAttribute:Ljava/util/ArrayList;

    iget v13, p0, Landroid/media/TimedTextEx;->mIndex:I

    invoke-virtual {v12, v13, v0}, Ljava/util/ArrayList;->set(ILjava/lang/Object;)Ljava/lang/Object;

    return-void
.end method

.method private readCommand_TapOffset1()V
    .locals 4

    .prologue
    const-string v2, "TimedTextEx"

    const-string v3, "readCommand_TapOffset1"

    invoke-static {v2, v3}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    const/4 v1, 0x1

    .local v1, "tapoffset":I
    new-instance v0, Landroid/media/TimedTextEx$TapOffset1;

    invoke-direct {v0, v1}, Landroid/media/TimedTextEx$TapOffset1;-><init>(I)V

    .local v0, "tapOffset1":Landroid/media/TimedTextEx$TapOffset1;
    iget-object v2, p0, Landroid/media/TimedTextEx;->mTapOffset1:Ljava/util/ArrayList;

    iget v3, p0, Landroid/media/TimedTextEx;->mIndex:I

    invoke-virtual {v2, v3, v0}, Ljava/util/ArrayList;->set(ILjava/lang/Object;)Ljava/lang/Object;

    return-void
.end method

.method private readCommand_TapOffset2()V
    .locals 4

    .prologue
    const-string v2, "TimedTextEx"

    const-string v3, "readCommand_TapOffset2"

    invoke-static {v2, v3}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    const/4 v1, 0x1

    .local v1, "tapoffset":I
    new-instance v0, Landroid/media/TimedTextEx$TapOffset2;

    invoke-direct {v0, v1}, Landroid/media/TimedTextEx$TapOffset2;-><init>(I)V

    .local v0, "tapOffset2":Landroid/media/TimedTextEx$TapOffset2;
    iget-object v2, p0, Landroid/media/TimedTextEx;->mTapOffset2:Ljava/util/ArrayList;

    iget v3, p0, Landroid/media/TimedTextEx;->mIndex:I

    invoke-virtual {v2, v3, v0}, Ljava/util/ArrayList;->set(ILjava/lang/Object;)Ljava/lang/Object;

    return-void
.end method

.method private readCommand_TapOffset3()V
    .locals 4

    .prologue
    const-string v2, "TimedTextEx"

    const-string v3, "readCommand_TapOffset3"

    invoke-static {v2, v3}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    const/4 v1, 0x1

    .local v1, "tapoffset":I
    new-instance v0, Landroid/media/TimedTextEx$TapOffset3;

    invoke-direct {v0, v1}, Landroid/media/TimedTextEx$TapOffset3;-><init>(I)V

    .local v0, "tapOffset3":Landroid/media/TimedTextEx$TapOffset3;
    iget-object v2, p0, Landroid/media/TimedTextEx;->mTapOffset3:Ljava/util/ArrayList;

    iget v3, p0, Landroid/media/TimedTextEx;->mIndex:I

    invoke-virtual {v2, v3, v0}, Ljava/util/ArrayList;->set(ILjava/lang/Object;)Ljava/lang/Object;

    return-void
.end method

.method private readCommand_TextAttribute(Landroid/os/Parcel;)V
    .locals 5
    .param p1, "parcel"    # Landroid/os/Parcel;

    .prologue
    const-string v3, "TimedTextEx"

    const-string v4, "readCommand_TextAttribute"

    invoke-static {v3, v4}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    invoke-virtual {p1}, Landroid/os/Parcel;->readInt()I

    move-result v0

    .local v0, "color":I
    invoke-virtual {p1}, Landroid/os/Parcel;->readInt()I

    move-result v1

    .local v1, "font":I
    new-instance v2, Landroid/media/TimedTextEx$TextAttribute;

    invoke-direct {v2, v0, v1}, Landroid/media/TimedTextEx$TextAttribute;-><init>(II)V

    .local v2, "textAttribute":Landroid/media/TimedTextEx$TextAttribute;
    iget-object v3, p0, Landroid/media/TimedTextEx;->mTextAttribute:Ljava/util/ArrayList;

    iget v4, p0, Landroid/media/TimedTextEx;->mIndex:I

    invoke-virtual {v3, v4, v2}, Ljava/util/ArrayList;->set(ILjava/lang/Object;)Ljava/lang/Object;

    return-void
.end method

.method private readCommand_ToggleWindows(Landroid/os/Parcel;)V
    .locals 4
    .param p1, "parcel"    # Landroid/os/Parcel;

    .prologue
    const-string v2, "TimedTextEx"

    const-string v3, "readCommand_ToggleWindows"

    invoke-static {v2, v3}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    invoke-virtual {p1}, Landroid/os/Parcel;->readInt()I

    move-result v1

    .local v1, "windowMap":I
    new-instance v0, Landroid/media/TimedTextEx$ToggleWindows;

    invoke-direct {v0, v1}, Landroid/media/TimedTextEx$ToggleWindows;-><init>(I)V

    .local v0, "toggleWins":Landroid/media/TimedTextEx$ToggleWindows;
    iget-object v2, p0, Landroid/media/TimedTextEx;->mToggleWins:Ljava/util/ArrayList;

    iget v3, p0, Landroid/media/TimedTextEx;->mIndex:I

    invoke-virtual {v2, v3, v0}, Ljava/util/ArrayList;->set(ILjava/lang/Object;)Ljava/lang/Object;

    return-void
.end method


# virtual methods
.method public getData()[B
    .locals 1

    .prologue
    iget-object v0, p0, Landroid/media/TimedTextEx;->mData:[B

    return-object v0
.end method

.method public getLanguage()Ljava/util/ArrayList;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/ArrayList",
            "<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    .prologue
    iget-object v0, p0, Landroid/media/TimedTextEx;->mLanguageList:Ljava/util/ArrayList;

    return-object v0
.end method

.method public getLanguageCount()I
    .locals 1

    .prologue
    iget v0, p0, Landroid/media/TimedTextEx;->mLanguageCount:I

    return v0
.end method

.method public getMimeType()Ljava/lang/String;
    .locals 1

    .prologue
    iget-object v0, p0, Landroid/media/TimedTextEx;->mMimeTypeChars:Ljava/lang/String;

    return-object v0
.end method

.method public getObject(I)Ljava/lang/Object;
    .locals 3
    .param p1, "key"    # I

    .prologue
    const-string v0, "TimedTextEx"

    const-string v1, "getObject"

    invoke-static {v0, v1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    invoke-direct {p0, p1}, Landroid/media/TimedTextEx;->isValidKey(I)Z

    move-result v0

    if-eqz v0, :cond_1

    iget-object v0, p0, Landroid/media/TimedTextEx;->mKeyObjectMap:Ljava/util/HashMap;

    invoke-static {p1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/util/HashMap;->containsKey(Ljava/lang/Object;)Z

    move-result v0

    const/4 v1, 0x1

    if-ne v0, v1, :cond_0

    iget-object v0, p0, Landroid/media/TimedTextEx;->mKeyObjectMap:Ljava/util/HashMap;

    invoke-static {p1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    :goto_0
    return-object v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0

    :cond_1
    new-instance v0, Ljava/lang/IllegalArgumentException;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Invalid key: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public getServiceNumber()[I
    .locals 1

    .prologue
    iget-object v0, p0, Landroid/media/TimedTextEx;->mServiceNumberList:[I

    return-object v0
.end method

.method public getServiceNumberMax()I
    .locals 1

    .prologue
    iget v0, p0, Landroid/media/TimedTextEx;->mServiceNumberMax:I

    return v0
.end method

.method public getStartTimeMs()I
    .locals 1

    .prologue
    iget v0, p0, Landroid/media/TimedTextEx;->mStartTimeMs:I

    return v0
.end method

.method public getTextList()Ljava/util/ArrayList;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/ArrayList",
            "<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    .prologue
    iget-object v0, p0, Landroid/media/TimedTextEx;->mTextList:Ljava/util/ArrayList;

    return-object v0
.end method

.method public keySet()Ljava/util/Set;
    .locals 2

    .prologue
    const-string v0, "TimedTextEx"

    const-string v1, "keySet"

    invoke-static {v0, v1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    iget-object v0, p0, Landroid/media/TimedTextEx;->mKeyObjectMap:Ljava/util/HashMap;

    invoke-virtual {v0}, Ljava/util/HashMap;->keySet()Ljava/util/Set;

    move-result-object v0

    return-object v0
.end method

.method protected parseParcelEx(Landroid/os/Parcel;)Z
    .locals 27
    .param p1, "parcel"    # Landroid/os/Parcel;

    .prologue
    const-string v24, "TimedTextEx"

    const-string v25, "TimedTextEx.parseParcelEx"

    invoke-static/range {v24 .. v25}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    const/16 v24, 0x0

    move-object/from16 v0, p1

    move/from16 v1, v24

    invoke-virtual {v0, v1}, Landroid/os/Parcel;->setDataPosition(I)V

    invoke-virtual/range {p1 .. p1}, Landroid/os/Parcel;->dataAvail()I

    move-result v24

    if-nez v24, :cond_0

    const-string v24, "TimedTextEx"

    const-string v25, "parseParcel data zero "

    invoke-static/range {v24 .. v25}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    const/16 v24, 0x0

    :goto_0
    return v24

    :cond_0
    const/4 v7, 0x0

    .local v7, "isCommandKey":Z
    const/4 v5, 0x0

    .local v5, "dataPosition":I
    invoke-virtual/range {p1 .. p1}, Landroid/os/Parcel;->readInt()I

    move-result v23

    .local v23, "type":I
    const/16 v24, 0x192

    move/from16 v0, v23

    move/from16 v1, v24

    if-ne v0, v1, :cond_12

    invoke-virtual/range {p1 .. p1}, Landroid/os/Parcel;->readInt()I

    move-result v23

    const/16 v24, 0x1

    move/from16 v0, v23

    move/from16 v1, v24

    if-eq v0, v1, :cond_1

    const-string v24, "TimedTextEx"

    new-instance v25, Ljava/lang/StringBuilder;

    invoke-direct/range {v25 .. v25}, Ljava/lang/StringBuilder;-><init>()V

    move-object/from16 v0, v25

    move/from16 v1, v23

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v25

    const-string v26, "!= KEY_MEDIA_MIMETYPE"

    invoke-virtual/range {v25 .. v26}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v25

    invoke-virtual/range {v25 .. v25}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v25

    invoke-static/range {v24 .. v25}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    const/16 v24, 0x0

    goto :goto_0

    :cond_1
    invoke-virtual/range {p1 .. p1}, Landroid/os/Parcel;->readInt()I

    move-result v17

    .local v17, "mimeTypeLen":I
    invoke-virtual/range {p1 .. p1}, Landroid/os/Parcel;->createByteArray()[B

    move-result-object v16

    .local v16, "mimeType":[B
    if-eqz v16, :cond_2

    move-object/from16 v0, v16

    array-length v0, v0

    move/from16 v24, v0

    if-nez v24, :cond_3

    :cond_2
    const-string v24, "TimedTextEx"

    const-string v25, "mimeType null"

    invoke-static/range {v24 .. v25}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    const/16 v24, 0x0

    move-object/from16 v0, v24

    move-object/from16 v1, p0

    iput-object v0, v1, Landroid/media/TimedTextEx;->mMimeTypeChars:Ljava/lang/String;

    :goto_1
    invoke-virtual/range {p1 .. p1}, Landroid/os/Parcel;->readInt()I

    move-result v23

    const/16 v24, 0x2

    move/from16 v0, v23

    move/from16 v1, v24

    if-eq v0, v1, :cond_4

    const-string v24, "TimedTextEx"

    new-instance v25, Ljava/lang/StringBuilder;

    invoke-direct/range {v25 .. v25}, Ljava/lang/StringBuilder;-><init>()V

    move-object/from16 v0, v25

    move/from16 v1, v23

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v25

    const-string v26, "!= KEY_START_TIME_US"

    invoke-virtual/range {v25 .. v26}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v25

    invoke-virtual/range {v25 .. v25}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v25

    invoke-static/range {v24 .. v25}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    const/16 v24, 0x0

    goto/16 :goto_0

    :cond_3
    new-instance v24, Ljava/lang/String;

    move-object/from16 v0, v24

    move-object/from16 v1, v16

    invoke-direct {v0, v1}, Ljava/lang/String;-><init>([B)V

    move-object/from16 v0, v24

    move-object/from16 v1, p0

    iput-object v0, v1, Landroid/media/TimedTextEx;->mMimeTypeChars:Ljava/lang/String;

    const-string v24, "TimedTextEx"

    new-instance v25, Ljava/lang/StringBuilder;

    invoke-direct/range {v25 .. v25}, Ljava/lang/StringBuilder;-><init>()V

    const-string v26, "KEY_MEDIA_MIMETYPE "

    invoke-virtual/range {v25 .. v26}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v25

    move-object/from16 v0, p0

    iget-object v0, v0, Landroid/media/TimedTextEx;->mMimeTypeChars:Ljava/lang/String;

    move-object/from16 v26, v0

    invoke-virtual/range {v25 .. v26}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v25

    invoke-virtual/range {v25 .. v25}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v25

    invoke-static/range {v24 .. v25}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_1

    :cond_4
    invoke-virtual/range {p1 .. p1}, Landroid/os/Parcel;->readInt()I

    move-result v24

    move/from16 v0, v24

    move-object/from16 v1, p0

    iput v0, v1, Landroid/media/TimedTextEx;->mStartTimeMs:I

    invoke-virtual/range {p1 .. p1}, Landroid/os/Parcel;->readInt()I

    move-result v23

    const/16 v24, 0x3

    move/from16 v0, v23

    move/from16 v1, v24

    if-eq v0, v1, :cond_5

    const-string v24, "TimedTextEx"

    new-instance v25, Ljava/lang/StringBuilder;

    invoke-direct/range {v25 .. v25}, Ljava/lang/StringBuilder;-><init>()V

    move-object/from16 v0, v25

    move/from16 v1, v23

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v25

    const-string v26, "!= KEY_LANGUAGE_COUNT"

    invoke-virtual/range {v25 .. v26}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v25

    invoke-virtual/range {v25 .. v25}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v25

    invoke-static/range {v24 .. v25}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    const/16 v24, 0x0

    goto/16 :goto_0

    :cond_5
    invoke-virtual/range {p1 .. p1}, Landroid/os/Parcel;->readInt()I

    move-result v24

    move/from16 v0, v24

    move-object/from16 v1, p0

    iput v0, v1, Landroid/media/TimedTextEx;->mLanguageCount:I

    const-string v24, "TimedTextEx"

    new-instance v25, Ljava/lang/StringBuilder;

    invoke-direct/range {v25 .. v25}, Ljava/lang/StringBuilder;-><init>()V

    const-string v26, "KEY_LANGUAGE_COUNT ["

    invoke-virtual/range {v25 .. v26}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v25

    move-object/from16 v0, p0

    iget v0, v0, Landroid/media/TimedTextEx;->mLanguageCount:I

    move/from16 v26, v0

    invoke-virtual/range {v25 .. v26}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v25

    const-string v26, "] "

    invoke-virtual/range {v25 .. v26}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v25

    invoke-virtual/range {v25 .. v25}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v25

    invoke-static/range {v24 .. v25}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    const/4 v4, 0x0

    .local v4, "count":I
    :goto_2
    const/16 v24, 0x44

    move/from16 v0, v24

    if-ge v4, v0, :cond_6

    move-object/from16 v0, p0

    iget-object v0, v0, Landroid/media/TimedTextEx;->mServiceNumberList:[I

    move-object/from16 v24, v0

    const/16 v25, -0x1

    aput v25, v24, v4

    add-int/lit8 v4, v4, 0x1

    goto :goto_2

    :cond_6
    invoke-direct/range {p0 .. p0}, Landroid/media/TimedTextEx;->initCommand()V

    const/4 v6, 0x0

    .local v6, "i":I
    :goto_3
    move-object/from16 v0, p0

    iget v0, v0, Landroid/media/TimedTextEx;->mLanguageCount:I

    move/from16 v24, v0

    move/from16 v0, v24

    if-ge v6, v0, :cond_15

    move-object/from16 v0, p0

    iput v6, v0, Landroid/media/TimedTextEx;->mIndex:I

    invoke-virtual/range {p1 .. p1}, Landroid/os/Parcel;->readInt()I

    move-result v23

    const/16 v24, 0xc

    move/from16 v0, v23

    move/from16 v1, v24

    if-eq v0, v1, :cond_7

    const-string v24, "TimedTextEx"

    new-instance v25, Ljava/lang/StringBuilder;

    invoke-direct/range {v25 .. v25}, Ljava/lang/StringBuilder;-><init>()V

    move-object/from16 v0, v25

    move/from16 v1, v23

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v25

    const-string v26, "!= KEY_EX_MAX_SERVICE_NUM"

    invoke-virtual/range {v25 .. v26}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v25

    invoke-virtual/range {v25 .. v25}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v25

    invoke-static/range {v24 .. v25}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    const/16 v24, 0x0

    goto/16 :goto_0

    :cond_7
    invoke-virtual/range {p1 .. p1}, Landroid/os/Parcel;->readInt()I

    move-result v24

    move/from16 v0, v24

    move-object/from16 v1, p0

    iput v0, v1, Landroid/media/TimedTextEx;->mServiceNumberMax:I

    invoke-virtual/range {p1 .. p1}, Landroid/os/Parcel;->readInt()I

    move-result v23

    const/16 v24, 0xb

    move/from16 v0, v23

    move/from16 v1, v24

    if-eq v0, v1, :cond_8

    const-string v24, "TimedTextEx"

    new-instance v25, Ljava/lang/StringBuilder;

    invoke-direct/range {v25 .. v25}, Ljava/lang/StringBuilder;-><init>()V

    move-object/from16 v0, v25

    move/from16 v1, v23

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v25

    const-string v26, "!= KEY_EX_SERVICE_NUM"

    invoke-virtual/range {v25 .. v26}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v25

    invoke-virtual/range {v25 .. v25}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v25

    invoke-static/range {v24 .. v25}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    const/16 v24, 0x0

    goto/16 :goto_0

    :cond_8
    invoke-virtual/range {p1 .. p1}, Landroid/os/Parcel;->readInt()I

    move-result v14

    .local v14, "mServiceNumber":I
    move-object/from16 v0, p0

    iget-object v0, v0, Landroid/media/TimedTextEx;->mServiceNumberList:[I

    move-object/from16 v24, v0

    aput v14, v24, v6

    invoke-virtual/range {p1 .. p1}, Landroid/os/Parcel;->readInt()I

    move-result v23

    const/16 v24, 0x4

    move/from16 v0, v23

    move/from16 v1, v24

    if-eq v0, v1, :cond_9

    const-string v24, "TimedTextEx"

    new-instance v25, Ljava/lang/StringBuilder;

    invoke-direct/range {v25 .. v25}, Ljava/lang/StringBuilder;-><init>()V

    move-object/from16 v0, v25

    move/from16 v1, v23

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v25

    const-string v26, "!= KEY_LANGUAGE"

    invoke-virtual/range {v25 .. v26}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v25

    invoke-virtual/range {v25 .. v25}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v25

    invoke-static/range {v24 .. v25}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    const/16 v24, 0x0

    goto/16 :goto_0

    :cond_9
    invoke-virtual/range {p1 .. p1}, Landroid/os/Parcel;->readInt()I

    move-result v10

    .local v10, "languageLen":I
    invoke-virtual/range {p1 .. p1}, Landroid/os/Parcel;->createByteArray()[B

    move-result-object v9

    .local v9, "language":[B
    const/4 v13, 0x0

    .local v13, "mLanguageChars":Ljava/lang/String;
    if-eqz v9, :cond_a

    array-length v0, v9

    move/from16 v24, v0

    if-nez v24, :cond_d

    :cond_a
    const-string v24, "TimedTextEx"

    const-string v25, "language null"

    invoke-static/range {v24 .. v25}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    :goto_4
    invoke-virtual/range {p1 .. p1}, Landroid/os/Parcel;->readInt()I

    move-result v23

    const/16 v24, 0x5

    move/from16 v0, v23

    move/from16 v1, v24

    if-ne v0, v1, :cond_10

    invoke-virtual/range {p1 .. p1}, Landroid/os/Parcel;->readInt()I

    move-result v21

    .local v21, "textLen":I
    invoke-virtual/range {p1 .. p1}, Landroid/os/Parcel;->createByteArray()[B

    move-result-object v20

    .local v20, "text":[B
    const/4 v15, 0x0

    .local v15, "mTextChars":Ljava/lang/String;
    if-eqz v20, :cond_b

    move-object/from16 v0, v20

    array-length v0, v0

    move/from16 v24, v0

    if-nez v24, :cond_e

    :cond_b
    new-instance v15, Ljava/lang/String;

    .end local v15    # "mTextChars":Ljava/lang/String;
    invoke-direct {v15}, Ljava/lang/String;-><init>()V

    .restart local v15    # "mTextChars":Ljava/lang/String;
    move-object/from16 v0, p0

    iget-object v0, v0, Landroid/media/TimedTextEx;->mTextList:Ljava/util/ArrayList;

    move-object/from16 v24, v0

    move-object/from16 v0, v24

    invoke-virtual {v0, v15}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    const-string v24, "TimedTextEx"

    const-string v25, "text null"

    invoke-static/range {v24 .. v25}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    :goto_5
    move-object/from16 v0, p0

    iget-object v0, v0, Landroid/media/TimedTextEx;->mServiceNumberList:[I

    move-object/from16 v24, v0

    aget v24, v24, v6

    if-lez v24, :cond_c

    invoke-virtual/range {p1 .. p1}, Landroid/os/Parcel;->dataAvail()I

    move-result v24

    if-lez v24, :cond_c

    invoke-virtual/range {p1 .. p1}, Landroid/os/Parcel;->dataPosition()I

    move-result v5

    invoke-virtual/range {p1 .. p1}, Landroid/os/Parcel;->readInt()I

    move-result v23

    const-string v24, "TimedTextEx"

    new-instance v25, Ljava/lang/StringBuilder;

    invoke-direct/range {v25 .. v25}, Ljava/lang/StringBuilder;-><init>()V

    const-string v26, "Check if there is a command ["

    invoke-virtual/range {v25 .. v26}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v25

    move-object/from16 v0, v25

    invoke-virtual {v0, v6}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v25

    const-string v26, "] "

    invoke-virtual/range {v25 .. v26}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v25

    const-string v26, "dataPosition:"

    invoke-virtual/range {v25 .. v26}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v25

    move-object/from16 v0, v25

    invoke-virtual {v0, v5}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v25

    const-string v26, " type:"

    invoke-virtual/range {v25 .. v26}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v25

    move-object/from16 v0, v25

    move/from16 v1, v23

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v25

    invoke-virtual/range {v25 .. v25}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v25

    invoke-static/range {v24 .. v25}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    const/16 v24, 0x6

    move/from16 v0, v23

    move/from16 v1, v24

    if-ne v0, v1, :cond_f

    const-string v24, "TimedTextEx"

    const-string v25, "KEY_EX_COMMAND start"

    invoke-static/range {v24 .. v25}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    invoke-direct/range {p0 .. p1}, Landroid/media/TimedTextEx;->readCommand(Landroid/os/Parcel;)Z

    move-result v7

    .end local v15    # "mTextChars":Ljava/lang/String;
    .end local v20    # "text":[B
    .end local v21    # "textLen":I
    :cond_c
    :goto_6
    add-int/lit8 v6, v6, 0x1

    goto/16 :goto_3

    :cond_d
    new-instance v13, Ljava/lang/String;

    .end local v13    # "mLanguageChars":Ljava/lang/String;
    invoke-direct {v13, v9}, Ljava/lang/String;-><init>([B)V

    .restart local v13    # "mLanguageChars":Ljava/lang/String;
    move-object/from16 v0, p0

    iget-object v0, v0, Landroid/media/TimedTextEx;->mLanguageList:Ljava/util/ArrayList;

    move-object/from16 v24, v0

    move-object/from16 v0, v24

    invoke-virtual {v0, v13}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    const-string v24, "TimedTextEx"

    new-instance v25, Ljava/lang/StringBuilder;

    invoke-direct/range {v25 .. v25}, Ljava/lang/StringBuilder;-><init>()V

    const-string v26, "KEY_LANGUAGE ["

    invoke-virtual/range {v25 .. v26}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v25

    move-object/from16 v0, v25

    invoke-virtual {v0, v6}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v25

    const-string v26, "] "

    invoke-virtual/range {v25 .. v26}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v25

    move-object/from16 v0, v25

    invoke-virtual {v0, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v25

    invoke-virtual/range {v25 .. v25}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v25

    invoke-static/range {v24 .. v25}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    goto/16 :goto_4

    .restart local v15    # "mTextChars":Ljava/lang/String;
    .restart local v20    # "text":[B
    .restart local v21    # "textLen":I
    :cond_e
    new-instance v15, Ljava/lang/String;

    .end local v15    # "mTextChars":Ljava/lang/String;
    move-object/from16 v0, v20

    invoke-direct {v15, v0}, Ljava/lang/String;-><init>([B)V

    .restart local v15    # "mTextChars":Ljava/lang/String;
    move-object/from16 v0, p0

    iget-object v0, v0, Landroid/media/TimedTextEx;->mTextList:Ljava/util/ArrayList;

    move-object/from16 v24, v0

    move-object/from16 v0, v24

    invoke-virtual {v0, v15}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    const-string v24, "TimedTextEx"

    new-instance v25, Ljava/lang/StringBuilder;

    invoke-direct/range {v25 .. v25}, Ljava/lang/StringBuilder;-><init>()V

    const-string v26, "KEY_EX_TEXT ["

    invoke-virtual/range {v25 .. v26}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v25

    move-object/from16 v0, v25

    invoke-virtual {v0, v6}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v25

    const-string v26, "] "

    invoke-virtual/range {v25 .. v26}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v25

    move-object/from16 v0, v25

    invoke-virtual {v0, v15}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v25

    const-string v26, " textLen:"

    invoke-virtual/range {v25 .. v26}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v25

    move-object/from16 v0, v25

    move/from16 v1, v21

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v25

    const-string v26, " text.length:"

    invoke-virtual/range {v25 .. v26}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v25

    move-object/from16 v0, v20

    array-length v0, v0

    move/from16 v26, v0

    invoke-virtual/range {v25 .. v26}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v25

    invoke-virtual/range {v25 .. v25}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v25

    invoke-static/range {v24 .. v25}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    goto/16 :goto_5

    :cond_f
    const-string v24, "TimedTextEx"

    const-string v25, "No KEY_EX_COMMAND"

    invoke-static/range {v24 .. v25}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    move-object/from16 v0, p1

    invoke-virtual {v0, v5}, Landroid/os/Parcel;->setDataPosition(I)V

    goto/16 :goto_6

    .end local v15    # "mTextChars":Ljava/lang/String;
    .end local v20    # "text":[B
    .end local v21    # "textLen":I
    :cond_10
    const/16 v24, 0xa

    move/from16 v0, v23

    move/from16 v1, v24

    if-ne v0, v1, :cond_c

    invoke-virtual/range {p1 .. p1}, Landroid/os/Parcel;->readInt()I

    move-result v12

    .local v12, "len":I
    const-string v24, "TimedTextEx"

    new-instance v25, Ljava/lang/StringBuilder;

    invoke-direct/range {v25 .. v25}, Ljava/lang/StringBuilder;-><init>()V

    const-string v26, "KEY_EX_DATA len:"

    invoke-virtual/range {v25 .. v26}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v25

    move-object/from16 v0, v25

    invoke-virtual {v0, v12}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v25

    invoke-virtual/range {v25 .. v25}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v25

    invoke-static/range {v24 .. v25}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    new-array v0, v12, [B

    move-object/from16 v24, v0

    move-object/from16 v0, v24

    move-object/from16 v1, p0

    iput-object v0, v1, Landroid/media/TimedTextEx;->mData:[B

    move-object/from16 v0, p0

    iget-object v0, v0, Landroid/media/TimedTextEx;->mData:[B

    move-object/from16 v24, v0

    move-object/from16 v0, p1

    move-object/from16 v1, v24

    invoke-virtual {v0, v1}, Landroid/os/Parcel;->readByteArray([B)V

    move-object/from16 v0, p0

    iget-object v0, v0, Landroid/media/TimedTextEx;->mData:[B

    move-object/from16 v24, v0

    if-nez v24, :cond_11

    const-string v24, "TimedTextEx"

    new-instance v25, Ljava/lang/StringBuilder;

    invoke-direct/range {v25 .. v25}, Ljava/lang/StringBuilder;-><init>()V

    const-string v26, "**** parseParcel **** KEY_STRUCT_TEXT mData null :"

    invoke-virtual/range {v25 .. v26}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v25

    move-object/from16 v0, v25

    move/from16 v1, v23

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v25

    invoke-virtual/range {v25 .. v25}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v25

    invoke-static/range {v24 .. v25}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    goto/16 :goto_6

    :cond_11
    move-object/from16 v0, p0

    iget-object v0, v0, Landroid/media/TimedTextEx;->mData:[B

    move-object/from16 v24, v0

    move-object/from16 v0, v24

    array-length v0, v0

    move/from16 v24, v0

    if-nez v24, :cond_c

    const-string v24, "TimedTextEx"

    new-instance v25, Ljava/lang/StringBuilder;

    invoke-direct/range {v25 .. v25}, Ljava/lang/StringBuilder;-><init>()V

    const-string v26, "**** parseParcel **** KEY_STRUCT_TEXT mData.length zero :"

    invoke-virtual/range {v25 .. v26}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v25

    move-object/from16 v0, v25

    move/from16 v1, v23

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v25

    invoke-virtual/range {v25 .. v25}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v25

    invoke-static/range {v24 .. v25}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    goto/16 :goto_6

    .end local v4    # "count":I
    .end local v6    # "i":I
    .end local v9    # "language":[B
    .end local v10    # "languageLen":I
    .end local v12    # "len":I
    .end local v13    # "mLanguageChars":Ljava/lang/String;
    .end local v14    # "mServiceNumber":I
    .end local v16    # "mimeType":[B
    .end local v17    # "mimeTypeLen":I
    :cond_12
    const/16 v24, 0x191

    move/from16 v0, v23

    move/from16 v1, v24

    if-eq v0, v1, :cond_15

    const-string v24, "TimedTextEx"

    new-instance v25, Ljava/lang/StringBuilder;

    invoke-direct/range {v25 .. v25}, Ljava/lang/StringBuilder;-><init>()V

    const-string v26, "[1] Invalid timed text ex key found: "

    invoke-virtual/range {v25 .. v26}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v25

    move-object/from16 v0, v25

    move/from16 v1, v23

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v25

    invoke-virtual/range {v25 .. v25}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v25

    invoke-static/range {v24 .. v25}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    const/16 v24, 0x0

    goto/16 :goto_0

    .local v8, "key":I
    :cond_13
    const/16 v18, 0x0

    .local v18, "object":Ljava/lang/Object;
    packed-switch v8, :pswitch_data_0

    .end local v18    # "object":Ljava/lang/Object;
    :goto_7
    if-eqz v18, :cond_15

    move-object/from16 v0, p0

    iget-object v0, v0, Landroid/media/TimedTextEx;->mKeyObjectMap:Ljava/util/HashMap;

    move-object/from16 v24, v0

    invoke-static {v8}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v25

    invoke-virtual/range {v24 .. v25}, Ljava/util/HashMap;->containsKey(Ljava/lang/Object;)Z

    move-result v24

    if-eqz v24, :cond_14

    move-object/from16 v0, p0

    iget-object v0, v0, Landroid/media/TimedTextEx;->mKeyObjectMap:Ljava/util/HashMap;

    move-object/from16 v24, v0

    invoke-static {v8}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v25

    invoke-virtual/range {v24 .. v25}, Ljava/util/HashMap;->remove(Ljava/lang/Object;)Ljava/lang/Object;

    :cond_14
    move-object/from16 v0, p0

    iget-object v0, v0, Landroid/media/TimedTextEx;->mKeyObjectMap:Ljava/util/HashMap;

    move-object/from16 v24, v0

    invoke-static {v8}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v25

    move-object/from16 v0, v24

    move-object/from16 v1, v25

    move-object/from16 v2, v18

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .end local v8    # "key":I
    :cond_15
    invoke-virtual/range {p1 .. p1}, Landroid/os/Parcel;->dataAvail()I

    move-result v24

    if-lez v24, :cond_16

    invoke-virtual/range {p1 .. p1}, Landroid/os/Parcel;->readInt()I

    move-result v8

    .restart local v8    # "key":I
    move-object/from16 v0, p0

    invoke-direct {v0, v8}, Landroid/media/TimedTextEx;->isValidKey(I)Z

    move-result v24

    if-nez v24, :cond_13

    const-string v24, "TimedTextEx"

    new-instance v25, Ljava/lang/StringBuilder;

    invoke-direct/range {v25 .. v25}, Ljava/lang/StringBuilder;-><init>()V

    const-string v26, "[2] Invalid timed text ex key found: "

    invoke-virtual/range {v25 .. v26}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v25

    move-object/from16 v0, v25

    invoke-virtual {v0, v8}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v25

    invoke-virtual/range {v25 .. v25}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v25

    invoke-static/range {v24 .. v25}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    const/16 v24, 0x0

    goto/16 :goto_0

    .restart local v18    # "object":Ljava/lang/Object;
    :pswitch_0
    invoke-virtual/range {p1 .. p1}, Landroid/os/Parcel;->readInt()I

    move-result v22

    .local v22, "top":I
    invoke-virtual/range {p1 .. p1}, Landroid/os/Parcel;->readInt()I

    move-result v11

    .local v11, "left":I
    invoke-virtual/range {p1 .. p1}, Landroid/os/Parcel;->readInt()I

    move-result v3

    .local v3, "bottom":I
    invoke-virtual/range {p1 .. p1}, Landroid/os/Parcel;->readInt()I

    move-result v19

    .local v19, "right":I
    new-instance v24, Landroid/graphics/Rect;

    move-object/from16 v0, v24

    move/from16 v1, v22

    move/from16 v2, v19

    invoke-direct {v0, v11, v1, v2, v3}, Landroid/graphics/Rect;-><init>(IIII)V

    move-object/from16 v0, v24

    move-object/from16 v1, p0

    iput-object v0, v1, Landroid/media/TimedTextEx;->mTextBounds:Landroid/graphics/Rect;

    move-object/from16 v0, p0

    iget-object v0, v0, Landroid/media/TimedTextEx;->mTextBounds:Landroid/graphics/Rect;

    move-object/from16 v18, v0

    .local v18, "object":Landroid/graphics/Rect;
    goto/16 :goto_7

    .end local v3    # "bottom":I
    .end local v11    # "left":I
    .end local v19    # "right":I
    .end local v22    # "top":I
    .local v18, "object":Ljava/lang/Object;
    :pswitch_1
    invoke-virtual/range {p1 .. p1}, Landroid/os/Parcel;->readInt()I

    move-result v24

    move/from16 v0, v24

    move-object/from16 v1, p0

    iput v0, v1, Landroid/media/TimedTextEx;->mHeight:I

    move-object/from16 v0, p0

    iget v0, v0, Landroid/media/TimedTextEx;->mHeight:I

    move/from16 v24, v0

    invoke-static/range {v24 .. v24}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v18

    .local v18, "object":Ljava/lang/Integer;
    goto/16 :goto_7

    .local v18, "object":Ljava/lang/Object;
    :pswitch_2
    invoke-virtual/range {p1 .. p1}, Landroid/os/Parcel;->readInt()I

    move-result v24

    move/from16 v0, v24

    move-object/from16 v1, p0

    iput v0, v1, Landroid/media/TimedTextEx;->mWidth:I

    move-object/from16 v0, p0

    iget v0, v0, Landroid/media/TimedTextEx;->mWidth:I

    move/from16 v24, v0

    invoke-static/range {v24 .. v24}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v18

    .local v18, "object":Ljava/lang/Integer;
    goto/16 :goto_7

    .end local v8    # "key":I
    .end local v18    # "object":Ljava/lang/Integer;
    :cond_16
    const/16 v24, 0x1

    goto/16 :goto_0

    :pswitch_data_0
    .packed-switch 0x7
        :pswitch_0
        :pswitch_1
        :pswitch_2
    .end packed-switch
.end method
