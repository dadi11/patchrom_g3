.class Landroid/widget/SimpleMonthAdapter;
.super Landroid/widget/BaseAdapter;
.source "SimpleMonthAdapter.java"

# interfaces
.implements Landroid/widget/SimpleMonthView$OnDayClickListener;


# static fields
.field private static final TAG:Ljava/lang/String; = "SimpleMonthAdapter"


# instance fields
.field private mCalendarTextColors:Landroid/content/res/ColorStateList;

.field private final mContext:Landroid/content/Context;

.field private final mController:Landroid/widget/DatePickerController;

.field private mSelectedDay:Ljava/util/Calendar;


# direct methods
.method public constructor <init>(Landroid/content/Context;Landroid/widget/DatePickerController;)V
    .locals 1
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "controller"    # Landroid/widget/DatePickerController;

    .prologue
    invoke-direct {p0}, Landroid/widget/BaseAdapter;-><init>()V

    iput-object p1, p0, Landroid/widget/SimpleMonthAdapter;->mContext:Landroid/content/Context;

    iput-object p2, p0, Landroid/widget/SimpleMonthAdapter;->mController:Landroid/widget/DatePickerController;

    invoke-virtual {p0}, Landroid/widget/SimpleMonthAdapter;->init()V

    iget-object v0, p0, Landroid/widget/SimpleMonthAdapter;->mController:Landroid/widget/DatePickerController;

    invoke-interface {v0}, Landroid/widget/DatePickerController;->getSelectedDay()Ljava/util/Calendar;

    move-result-object v0

    invoke-virtual {p0, v0}, Landroid/widget/SimpleMonthAdapter;->setSelectedDay(Ljava/util/Calendar;)V

    return-void
.end method

.method private isSelectedDayInMonth(II)Z
    .locals 3
    .param p1, "year"    # I
    .param p2, "month"    # I

    .prologue
    const/4 v0, 0x1

    iget-object v1, p0, Landroid/widget/SimpleMonthAdapter;->mSelectedDay:Ljava/util/Calendar;

    invoke-virtual {v1, v0}, Ljava/util/Calendar;->get(I)I

    move-result v1

    if-ne v1, p1, :cond_0

    iget-object v1, p0, Landroid/widget/SimpleMonthAdapter;->mSelectedDay:Ljava/util/Calendar;

    const/4 v2, 0x2

    invoke-virtual {v1, v2}, Ljava/util/Calendar;->get(I)I

    move-result v1

    if-ne v1, p2, :cond_0

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method


# virtual methods
.method public getCount()I
    .locals 4

    .prologue
    iget-object v2, p0, Landroid/widget/SimpleMonthAdapter;->mController:Landroid/widget/DatePickerController;

    invoke-interface {v2}, Landroid/widget/DatePickerController;->getMaxYear()I

    move-result v2

    iget-object v3, p0, Landroid/widget/SimpleMonthAdapter;->mController:Landroid/widget/DatePickerController;

    invoke-interface {v3}, Landroid/widget/DatePickerController;->getMinYear()I

    move-result v3

    sub-int v1, v2, v3

    .local v1, "diffYear":I
    iget-object v2, p0, Landroid/widget/SimpleMonthAdapter;->mController:Landroid/widget/DatePickerController;

    invoke-interface {v2}, Landroid/widget/DatePickerController;->getMaxMonth()I

    move-result v2

    add-int/lit8 v2, v2, 0x1

    iget-object v3, p0, Landroid/widget/SimpleMonthAdapter;->mController:Landroid/widget/DatePickerController;

    invoke-interface {v3}, Landroid/widget/DatePickerController;->getMinMonth()I

    move-result v3

    sub-int/2addr v2, v3

    mul-int/lit8 v3, v1, 0xc

    add-int v0, v2, v3

    .local v0, "diffMonth":I
    return v0
.end method

.method public getItem(I)Ljava/lang/Object;
    .locals 1
    .param p1, "position"    # I

    .prologue
    const/4 v0, 0x0

    return-object v0
.end method

.method public getItemId(I)J
    .locals 2
    .param p1, "position"    # I

    .prologue
    int-to-long v0, p1

    return-wide v0
.end method

.method public getView(ILandroid/view/View;Landroid/view/ViewGroup;)Landroid/view/View;
    .locals 11
    .param p1, "position"    # I
    .param p2, "convertView"    # Landroid/view/View;
    .param p3, "parent"    # Landroid/view/ViewGroup;

    .prologue
    const/4 v10, -0x1

    const/4 v8, 0x0

    .local v8, "drawingParams":Ljava/util/HashMap;, "Ljava/util/HashMap<Ljava/lang/String;Ljava/lang/Integer;>;"
    if-eqz p2, :cond_2

    move-object v0, p2

    check-cast v0, Landroid/widget/SimpleMonthView;

    .local v0, "v":Landroid/widget/SimpleMonthView;
    invoke-virtual {v0}, Landroid/widget/SimpleMonthView;->getTag()Ljava/lang/Object;

    move-result-object v8

    .end local v8    # "drawingParams":Ljava/util/HashMap;, "Ljava/util/HashMap<Ljava/lang/String;Ljava/lang/Integer;>;"
    check-cast v8, Ljava/util/HashMap;

    .restart local v8    # "drawingParams":Ljava/util/HashMap;, "Ljava/util/HashMap<Ljava/lang/String;Ljava/lang/Integer;>;"
    :cond_0
    :goto_0
    if-nez v8, :cond_3

    new-instance v8, Ljava/util/HashMap;

    .end local v8    # "drawingParams":Ljava/util/HashMap;, "Ljava/util/HashMap<Ljava/lang/String;Ljava/lang/Integer;>;"
    invoke-direct {v8}, Ljava/util/HashMap;-><init>()V

    .restart local v8    # "drawingParams":Ljava/util/HashMap;, "Ljava/util/HashMap<Ljava/lang/String;Ljava/lang/Integer;>;"
    :goto_1
    iget-object v4, p0, Landroid/widget/SimpleMonthAdapter;->mController:Landroid/widget/DatePickerController;

    invoke-interface {v4}, Landroid/widget/DatePickerController;->getMinMonth()I

    move-result v4

    add-int v7, p1, v4

    .local v7, "currentMonth":I
    rem-int/lit8 v2, v7, 0xc

    .local v2, "month":I
    div-int/lit8 v4, v7, 0xc

    iget-object v10, p0, Landroid/widget/SimpleMonthAdapter;->mController:Landroid/widget/DatePickerController;

    invoke-interface {v10}, Landroid/widget/DatePickerController;->getMinYear()I

    move-result v10

    add-int v3, v4, v10

    .local v3, "year":I
    const/4 v1, -0x1

    .local v1, "selectedDay":I
    invoke-direct {p0, v3, v2}, Landroid/widget/SimpleMonthAdapter;->isSelectedDayInMonth(II)Z

    move-result v4

    if-eqz v4, :cond_1

    iget-object v4, p0, Landroid/widget/SimpleMonthAdapter;->mSelectedDay:Ljava/util/Calendar;

    const/4 v10, 0x5

    invoke-virtual {v4, v10}, Ljava/util/Calendar;->get(I)I

    move-result v1

    :cond_1
    invoke-virtual {v0}, Landroid/widget/SimpleMonthView;->reuse()V

    iget-object v4, p0, Landroid/widget/SimpleMonthAdapter;->mController:Landroid/widget/DatePickerController;

    invoke-interface {v4}, Landroid/widget/DatePickerController;->getMinMonth()I

    move-result v4

    if-ne v4, v2, :cond_4

    iget-object v4, p0, Landroid/widget/SimpleMonthAdapter;->mController:Landroid/widget/DatePickerController;

    invoke-interface {v4}, Landroid/widget/DatePickerController;->getMinYear()I

    move-result v4

    if-ne v4, v3, :cond_4

    iget-object v4, p0, Landroid/widget/SimpleMonthAdapter;->mController:Landroid/widget/DatePickerController;

    invoke-interface {v4}, Landroid/widget/DatePickerController;->getMinDay()I

    move-result v5

    .local v5, "enabledDayRangeStart":I
    :goto_2
    iget-object v4, p0, Landroid/widget/SimpleMonthAdapter;->mController:Landroid/widget/DatePickerController;

    invoke-interface {v4}, Landroid/widget/DatePickerController;->getMaxMonth()I

    move-result v4

    if-ne v4, v2, :cond_5

    iget-object v4, p0, Landroid/widget/SimpleMonthAdapter;->mController:Landroid/widget/DatePickerController;

    invoke-interface {v4}, Landroid/widget/DatePickerController;->getMaxYear()I

    move-result v4

    if-ne v4, v3, :cond_5

    iget-object v4, p0, Landroid/widget/SimpleMonthAdapter;->mController:Landroid/widget/DatePickerController;

    invoke-interface {v4}, Landroid/widget/DatePickerController;->getMaxDay()I

    move-result v6

    .local v6, "enabledDayRangeEnd":I
    :goto_3
    iget-object v4, p0, Landroid/widget/SimpleMonthAdapter;->mController:Landroid/widget/DatePickerController;

    invoke-interface {v4}, Landroid/widget/DatePickerController;->getFirstDayOfWeek()I

    move-result v4

    invoke-virtual/range {v0 .. v6}, Landroid/widget/SimpleMonthView;->setMonthParams(IIIIII)V

    invoke-virtual {v0}, Landroid/widget/SimpleMonthView;->invalidate()V

    return-object v0

    .end local v0    # "v":Landroid/widget/SimpleMonthView;
    .end local v1    # "selectedDay":I
    .end local v2    # "month":I
    .end local v3    # "year":I
    .end local v5    # "enabledDayRangeStart":I
    .end local v6    # "enabledDayRangeEnd":I
    .end local v7    # "currentMonth":I
    :cond_2
    new-instance v0, Landroid/widget/SimpleMonthView;

    iget-object v4, p0, Landroid/widget/SimpleMonthAdapter;->mContext:Landroid/content/Context;

    invoke-direct {v0, v4}, Landroid/widget/SimpleMonthView;-><init>(Landroid/content/Context;)V

    .restart local v0    # "v":Landroid/widget/SimpleMonthView;
    new-instance v9, Landroid/widget/AbsListView$LayoutParams;

    invoke-direct {v9, v10, v10}, Landroid/widget/AbsListView$LayoutParams;-><init>(II)V

    .local v9, "params":Landroid/widget/AbsListView$LayoutParams;
    invoke-virtual {v0, v9}, Landroid/widget/SimpleMonthView;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    const/4 v4, 0x1

    invoke-virtual {v0, v4}, Landroid/widget/SimpleMonthView;->setClickable(Z)V

    invoke-virtual {v0, p0}, Landroid/widget/SimpleMonthView;->setOnDayClickListener(Landroid/widget/SimpleMonthView$OnDayClickListener;)V

    iget-object v4, p0, Landroid/widget/SimpleMonthAdapter;->mCalendarTextColors:Landroid/content/res/ColorStateList;

    if-eqz v4, :cond_0

    iget-object v4, p0, Landroid/widget/SimpleMonthAdapter;->mCalendarTextColors:Landroid/content/res/ColorStateList;

    invoke-virtual {v0, v4}, Landroid/widget/SimpleMonthView;->setTextColor(Landroid/content/res/ColorStateList;)V

    goto/16 :goto_0

    .end local v9    # "params":Landroid/widget/AbsListView$LayoutParams;
    :cond_3
    invoke-virtual {v8}, Ljava/util/HashMap;->clear()V

    goto/16 :goto_1

    .restart local v1    # "selectedDay":I
    .restart local v2    # "month":I
    .restart local v3    # "year":I
    .restart local v7    # "currentMonth":I
    :cond_4
    const/4 v5, 0x1

    .restart local v5    # "enabledDayRangeStart":I
    goto :goto_2

    :cond_5
    const/16 v6, 0x1f

    .restart local v6    # "enabledDayRangeEnd":I
    goto :goto_3
.end method

.method public hasStableIds()Z
    .locals 1

    .prologue
    const/4 v0, 0x1

    return v0
.end method

.method protected init()V
    .locals 1

    .prologue
    invoke-static {}, Ljava/util/Calendar;->getInstance()Ljava/util/Calendar;

    move-result-object v0

    iput-object v0, p0, Landroid/widget/SimpleMonthAdapter;->mSelectedDay:Ljava/util/Calendar;

    return-void
.end method

.method public onDayClick(Landroid/widget/SimpleMonthView;Ljava/util/Calendar;)V
    .locals 0
    .param p1, "view"    # Landroid/widget/SimpleMonthView;
    .param p2, "day"    # Ljava/util/Calendar;

    .prologue
    if-eqz p2, :cond_0

    invoke-virtual {p0, p2}, Landroid/widget/SimpleMonthAdapter;->onDayTapped(Ljava/util/Calendar;)V

    :cond_0
    return-void
.end method

.method protected onDayTapped(Ljava/util/Calendar;)V
    .locals 4
    .param p1, "day"    # Ljava/util/Calendar;

    .prologue
    iget-object v0, p0, Landroid/widget/SimpleMonthAdapter;->mController:Landroid/widget/DatePickerController;

    invoke-interface {v0}, Landroid/widget/DatePickerController;->tryVibrate()V

    iget-object v0, p0, Landroid/widget/SimpleMonthAdapter;->mController:Landroid/widget/DatePickerController;

    const/4 v1, 0x1

    invoke-virtual {p1, v1}, Ljava/util/Calendar;->get(I)I

    move-result v1

    const/4 v2, 0x2

    invoke-virtual {p1, v2}, Ljava/util/Calendar;->get(I)I

    move-result v2

    const/4 v3, 0x5

    invoke-virtual {p1, v3}, Ljava/util/Calendar;->get(I)I

    move-result v3

    invoke-interface {v0, v1, v2, v3}, Landroid/widget/DatePickerController;->onDayOfMonthSelected(III)V

    invoke-virtual {p0, p1}, Landroid/widget/SimpleMonthAdapter;->setSelectedDay(Ljava/util/Calendar;)V

    return-void
.end method

.method setCalendarTextColor(Landroid/content/res/ColorStateList;)V
    .locals 0
    .param p1, "colors"    # Landroid/content/res/ColorStateList;

    .prologue
    iput-object p1, p0, Landroid/widget/SimpleMonthAdapter;->mCalendarTextColors:Landroid/content/res/ColorStateList;

    return-void
.end method

.method public setSelectedDay(Ljava/util/Calendar;)V
    .locals 1
    .param p1, "day"    # Ljava/util/Calendar;

    .prologue
    iget-object v0, p0, Landroid/widget/SimpleMonthAdapter;->mSelectedDay:Ljava/util/Calendar;

    if-eq v0, p1, :cond_0

    iput-object p1, p0, Landroid/widget/SimpleMonthAdapter;->mSelectedDay:Ljava/util/Calendar;

    invoke-virtual {p0}, Landroid/widget/SimpleMonthAdapter;->notifyDataSetChanged()V

    :cond_0
    return-void
.end method
