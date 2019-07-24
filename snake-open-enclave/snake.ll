; ModuleID = 'snake.bc'
source_filename = "snake.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.itimerval = type { %struct.timeval, %struct.timeval }
%struct.timeval = type { i64, i64 }
%struct._IO_FILE = type { i32, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, %struct._IO_marker*, %struct._IO_FILE*, i32, i32, i64, i16, i8, [1 x i8], i8*, i64, i8*, i8*, i8*, i8*, i64, i32, [20 x i8] }
%struct._IO_marker = type { %struct._IO_marker*, %struct._IO_FILE*, i32 }
%struct.sigaction = type { %union.anon, %struct.__sigset_t, i32, void ()* }
%union.anon = type { void (i32)* }
%struct.__sigset_t = type { [16 x i64] }
%struct.screen_t = type { i32, i32, i32, i32, i32, [22 x [78 x i8]] }
%struct.snake_t = type { i32, i32, i32, [100 x %struct.snake_segment_t] }
%struct.snake_segment_t = type { i32, i32 }

@.str = private unnamed_addr constant [11 x i8] c"\1B[2J\1B[1;1H\00", align 1
@.str.1 = private unnamed_addr constant [10 x i8] c"stty sane\00", align 1
@alarm_handler.val = internal global %struct.itimerval zeroinitializer, align 8
@usec_delay = internal global i32 200000, align 4
@.str.2 = private unnamed_addr constant [9 x i8] c"\1B[%d;%dm\00", align 1
@.str.3 = private unnamed_addr constant [9 x i8] c"\1B[%d;%dH\00", align 1
@.str.4 = private unnamed_addr constant [12 x i8] c"Level: %05d\00", align 1
@.str.5 = private unnamed_addr constant [16 x i8] c"Gold Left: %05d\00", align 1
@.str.6 = private unnamed_addr constant [12 x i8] c"Score: %05d\00", align 1
@.str.7 = private unnamed_addr constant [17 x i8] c"High Score: %05d\00", align 1
@.str.8 = private unnamed_addr constant [2 x i8] c"+\00", align 1
@.str.9 = private unnamed_addr constant [2 x i8] c"-\00", align 1
@.str.10 = private unnamed_addr constant [6 x i8] c"\1B[%dm\00", align 1
@.str.11 = private unnamed_addr constant [2 x i8] c"|\00", align 1
@.str.12 = private unnamed_addr constant [3 x i8] c"%c\00", align 1
@.str.13 = private unnamed_addr constant [2 x i8] c" \00", align 1
@main.keys = private unnamed_addr constant [7 x i8] c"opazfjq", align 1
@.str.14 = private unnamed_addr constant [25 x i8] c"stty cbreak -echo stop u\00", align 1
@stderr = external global %struct._IO_FILE*, align 8
@.str.15 = private unnamed_addr constant [50 x i8] c"Failed setting up the screen, is 'stty' missing?\0A\00", align 1
@.str.16 = private unnamed_addr constant [19 x i8] c"-G A M E  O V E R-\00", align 1
@.str.17 = private unnamed_addr constant [21 x i8] c"Another Game (y/n)? \00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define i32 @sigsetup(i32 %signo, void (i32)* %callback) #0 {
entry:
  %signo.addr = alloca i32, align 4
  %callback.addr = alloca void (i32)*, align 8
  %action = alloca %struct.sigaction, align 8
  store i32 %signo, i32* %signo.addr, align 4
  store void (i32)* %callback, void (i32)** %callback.addr, align 8
  %sa_mask = getelementptr inbounds %struct.sigaction, %struct.sigaction* %action, i32 0, i32 1
  %call = call i32 @sigemptyset(%struct.__sigset_t* %sa_mask) #5
  %sa_flags = getelementptr inbounds %struct.sigaction, %struct.sigaction* %action, i32 0, i32 2
  store i32 0, i32* %sa_flags, align 8
  %0 = load void (i32)*, void (i32)** %callback.addr, align 8
  %__sigaction_handler = getelementptr inbounds %struct.sigaction, %struct.sigaction* %action, i32 0, i32 0
  %sa_handler = bitcast %union.anon* %__sigaction_handler to void (i32)**
  store void (i32)* %0, void (i32)** %sa_handler, align 8
  %1 = load i32, i32* %signo.addr, align 4
  %cmp = icmp eq i32 14, %1
  br i1 %cmp, label %if.then, label %if.else

if.then:                                          ; preds = %entry
  %sa_flags1 = getelementptr inbounds %struct.sigaction, %struct.sigaction* %action, i32 0, i32 2
  %2 = load i32, i32* %sa_flags1, align 8
  %or = or i32 %2, 536870912
  store i32 %or, i32* %sa_flags1, align 8
  br label %if.end

if.else:                                          ; preds = %entry
  %sa_flags2 = getelementptr inbounds %struct.sigaction, %struct.sigaction* %action, i32 0, i32 2
  %3 = load i32, i32* %sa_flags2, align 8
  %or3 = or i32 %3, 268435456
  store i32 %or3, i32* %sa_flags2, align 8
  br label %if.end

if.end:                                           ; preds = %if.else, %if.then
  %4 = load i32, i32* %signo.addr, align 4
  %call4 = call i32 @sigaction(i32 %4, %struct.sigaction* %action, %struct.sigaction* null) #5
  ret i32 %call4
}

; Function Attrs: nounwind
declare i32 @sigemptyset(%struct.__sigset_t*) #1

; Function Attrs: nounwind
declare i32 @sigaction(i32, %struct.sigaction*, %struct.sigaction*) #1

; Function Attrs: noinline nounwind optnone uwtable
define void @sig_handler(i32 %signal) #0 {
entry:
  %signal.addr = alloca i32, align 4
  store i32 %signal, i32* %signal.addr, align 4
  %call = call i32 @puts(i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str, i32 0, i32 0))
  %call1 = call i32 @system(i8* getelementptr inbounds ([10 x i8], [10 x i8]* @.str.1, i32 0, i32 0))
  %and = and i32 %call1, 65280
  %shr = ashr i32 %and, 8
  call void @exit(i32 %shr) #6
  unreachable

return:                                           ; No predecessors!
  ret void
}

declare i32 @puts(i8*) #2

; Function Attrs: noreturn nounwind
declare void @exit(i32) #3

declare i32 @system(i8*) #2

; Function Attrs: noinline nounwind optnone uwtable
define void @alarm_handler(i32 %signal) #0 {
entry:
  %signal.addr = alloca i32, align 4
  store i32 %signal, i32* %signal.addr, align 4
  %0 = load i32, i32* %signal.addr, align 4
  %tobool = icmp ne i32 %0, 0
  br i1 %tobool, label %if.end, label %if.then

if.then:                                          ; preds = %entry
  %call = call i32 @sigsetup(i32 14, void (i32)* @alarm_handler)
  br label %if.end

if.end:                                           ; preds = %if.then, %entry
  store i64 0, i64* getelementptr inbounds (%struct.itimerval, %struct.itimerval* @alarm_handler.val, i32 0, i32 1, i32 0), align 8
  %1 = load i32, i32* @usec_delay, align 4
  %conv = zext i32 %1 to i64
  store i64 %conv, i64* getelementptr inbounds (%struct.itimerval, %struct.itimerval* @alarm_handler.val, i32 0, i32 1, i32 1), align 8
  %call1 = call i32 @setitimer(i32 0, %struct.itimerval* @alarm_handler.val, %struct.itimerval* null) #5
  ret void
}

; Function Attrs: nounwind
declare i32 @setitimer(i32, %struct.itimerval*, %struct.itimerval*) #1

; Function Attrs: noinline nounwind optnone uwtable
define void @show_score(%struct.screen_t* %screen) #0 {
entry:
  %screen.addr = alloca %struct.screen_t*, align 8
  store %struct.screen_t* %screen, %struct.screen_t** %screen.addr, align 8
  %call = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([9 x i8], [9 x i8]* @.str.2, i32 0, i32 0), i32 1, i32 36)
  %call1 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([9 x i8], [9 x i8]* @.str.3, i32 0, i32 0), i32 24, i32 3)
  %0 = load %struct.screen_t*, %struct.screen_t** %screen.addr, align 8
  %level = getelementptr inbounds %struct.screen_t, %struct.screen_t* %0, i32 0, i32 0
  %1 = load i32, i32* %level, align 4
  %call2 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.4, i32 0, i32 0), i32 %1)
  %call3 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([9 x i8], [9 x i8]* @.str.2, i32 0, i32 0), i32 1, i32 33)
  %call4 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([9 x i8], [9 x i8]* @.str.3, i32 0, i32 0), i32 24, i32 21)
  %2 = load %struct.screen_t*, %struct.screen_t** %screen.addr, align 8
  %gold = getelementptr inbounds %struct.screen_t, %struct.screen_t* %2, i32 0, i32 3
  %3 = load i32, i32* %gold, align 4
  %call5 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([16 x i8], [16 x i8]* @.str.5, i32 0, i32 0), i32 %3)
  %call6 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([9 x i8], [9 x i8]* @.str.2, i32 0, i32 0), i32 1, i32 32)
  %call7 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([9 x i8], [9 x i8]* @.str.3, i32 0, i32 0), i32 24, i32 43)
  %4 = load %struct.screen_t*, %struct.screen_t** %screen.addr, align 8
  %score = getelementptr inbounds %struct.screen_t, %struct.screen_t* %4, i32 0, i32 1
  %5 = load i32, i32* %score, align 4
  %call8 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.6, i32 0, i32 0), i32 %5)
  %call9 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([9 x i8], [9 x i8]* @.str.2, i32 0, i32 0), i32 1, i32 35)
  %call10 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([9 x i8], [9 x i8]* @.str.3, i32 0, i32 0), i32 24, i32 61)
  %6 = load %struct.screen_t*, %struct.screen_t** %screen.addr, align 8
  %high_score = getelementptr inbounds %struct.screen_t, %struct.screen_t* %6, i32 0, i32 2
  %7 = load i32, i32* %high_score, align 4
  %call11 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([17 x i8], [17 x i8]* @.str.7, i32 0, i32 0), i32 %7)
  ret void
}

declare i32 @printf(i8*, ...) #2

; Function Attrs: noinline nounwind optnone uwtable
define void @draw_line(i32 %col, i32 %row) #0 {
entry:
  %col.addr = alloca i32, align 4
  %row.addr = alloca i32, align 4
  %i = alloca i32, align 4
  store i32 %col, i32* %col.addr, align 4
  store i32 %row, i32* %row.addr, align 4
  %0 = load i32, i32* %row.addr, align 4
  %1 = load i32, i32* %col.addr, align 4
  %call = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([9 x i8], [9 x i8]* @.str.3, i32 0, i32 0), i32 %0, i32 %1)
  %call1 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([9 x i8], [9 x i8]* @.str.2, i32 0, i32 0), i32 1, i32 44)
  %call2 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([9 x i8], [9 x i8]* @.str.2, i32 0, i32 0), i32 1, i32 34)
  store i32 0, i32* %i, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %2 = load i32, i32* %i, align 4
  %cmp = icmp slt i32 %2, 80
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %3 = load i32, i32* %i, align 4
  %cmp3 = icmp eq i32 %3, 0
  br i1 %cmp3, label %if.then, label %lor.lhs.false

lor.lhs.false:                                    ; preds = %for.body
  %4 = load i32, i32* %i, align 4
  %cmp4 = icmp eq i32 %4, 79
  br i1 %cmp4, label %if.then, label %if.else

if.then:                                          ; preds = %lor.lhs.false, %for.body
  %call5 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.8, i32 0, i32 0))
  br label %if.end

if.else:                                          ; preds = %lor.lhs.false
  %call6 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.9, i32 0, i32 0))
  br label %if.end

if.end:                                           ; preds = %if.else, %if.then
  br label %for.inc

for.inc:                                          ; preds = %if.end
  %5 = load i32, i32* %i, align 4
  %inc = add nsw i32 %5, 1
  store i32 %inc, i32* %i, align 4
  br label %for.cond

for.end:                                          ; preds = %for.cond
  %call7 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.10, i32 0, i32 0), i32 0)
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define void @setup_level(%struct.screen_t* %screen, %struct.snake_t* %snake, i32 %level) #0 {
entry:
  %screen.addr = alloca %struct.screen_t*, align 8
  %snake.addr = alloca %struct.snake_t*, align 8
  %level.addr = alloca i32, align 4
  %i = alloca i32, align 4
  %row = alloca i32, align 4
  %col = alloca i32, align 4
  store %struct.screen_t* %screen, %struct.screen_t** %screen.addr, align 8
  store %struct.snake_t* %snake, %struct.snake_t** %snake.addr, align 8
  store i32 %level, i32* %level.addr, align 4
  %call = call i64 @time(i64* null) #5
  %conv = trunc i64 %call to i32
  call void @srand(i32 %conv) #5
  %0 = load i32, i32* %level.addr, align 4
  %cmp = icmp eq i32 1, %0
  br i1 %cmp, label %if.then, label %if.else

if.then:                                          ; preds = %entry
  %1 = load %struct.screen_t*, %struct.screen_t** %screen.addr, align 8
  %score = getelementptr inbounds %struct.screen_t, %struct.screen_t* %1, i32 0, i32 1
  store i32 0, i32* %score, align 4
  %2 = load %struct.screen_t*, %struct.screen_t** %screen.addr, align 8
  %obstacles = getelementptr inbounds %struct.screen_t, %struct.screen_t* %2, i32 0, i32 4
  store i32 4, i32* %obstacles, align 4
  %3 = load %struct.screen_t*, %struct.screen_t** %screen.addr, align 8
  %level2 = getelementptr inbounds %struct.screen_t, %struct.screen_t* %3, i32 0, i32 0
  store i32 1, i32* %level2, align 4
  %4 = load %struct.snake_t*, %struct.snake_t** %snake.addr, align 8
  %speed = getelementptr inbounds %struct.snake_t, %struct.snake_t* %4, i32 0, i32 0
  store i32 14, i32* %speed, align 4
  %5 = load %struct.snake_t*, %struct.snake_t** %snake.addr, align 8
  %dir = getelementptr inbounds %struct.snake_t, %struct.snake_t* %5, i32 0, i32 1
  store i32 1, i32* %dir, align 4
  br label %if.end16

if.else:                                          ; preds = %entry
  %6 = load %struct.screen_t*, %struct.screen_t** %screen.addr, align 8
  %level3 = getelementptr inbounds %struct.screen_t, %struct.screen_t* %6, i32 0, i32 0
  %7 = load i32, i32* %level3, align 4
  %mul = mul nsw i32 %7, 1000
  %8 = load %struct.screen_t*, %struct.screen_t** %screen.addr, align 8
  %score4 = getelementptr inbounds %struct.screen_t, %struct.screen_t* %8, i32 0, i32 1
  %9 = load i32, i32* %score4, align 4
  %add = add nsw i32 %9, %mul
  store i32 %add, i32* %score4, align 4
  %10 = load %struct.screen_t*, %struct.screen_t** %screen.addr, align 8
  %obstacles5 = getelementptr inbounds %struct.screen_t, %struct.screen_t* %10, i32 0, i32 4
  %11 = load i32, i32* %obstacles5, align 4
  %add6 = add nsw i32 %11, 2
  store i32 %add6, i32* %obstacles5, align 4
  %12 = load %struct.screen_t*, %struct.screen_t** %screen.addr, align 8
  %level7 = getelementptr inbounds %struct.screen_t, %struct.screen_t* %12, i32 0, i32 0
  %13 = load i32, i32* %level7, align 4
  %inc = add nsw i32 %13, 1
  store i32 %inc, i32* %level7, align 4
  %14 = load %struct.screen_t*, %struct.screen_t** %screen.addr, align 8
  %level8 = getelementptr inbounds %struct.screen_t, %struct.screen_t* %14, i32 0, i32 0
  %15 = load i32, i32* %level8, align 4
  %rem = srem i32 %15, 5
  %cmp9 = icmp eq i32 %rem, 0
  br i1 %cmp9, label %land.lhs.true, label %if.end

land.lhs.true:                                    ; preds = %if.else
  %16 = load %struct.snake_t*, %struct.snake_t** %snake.addr, align 8
  %speed11 = getelementptr inbounds %struct.snake_t, %struct.snake_t* %16, i32 0, i32 0
  %17 = load i32, i32* %speed11, align 4
  %cmp12 = icmp ugt i32 %17, 1
  br i1 %cmp12, label %if.then14, label %if.end

if.then14:                                        ; preds = %land.lhs.true
  %18 = load %struct.snake_t*, %struct.snake_t** %snake.addr, align 8
  %speed15 = getelementptr inbounds %struct.snake_t, %struct.snake_t* %18, i32 0, i32 0
  %19 = load i32, i32* %speed15, align 4
  %dec = add i32 %19, -1
  store i32 %dec, i32* %speed15, align 4
  br label %if.end

if.end:                                           ; preds = %if.then14, %land.lhs.true, %if.else
  br label %if.end16

if.end16:                                         ; preds = %if.end, %if.then
  %20 = load %struct.screen_t*, %struct.screen_t** %screen.addr, align 8
  %gold = getelementptr inbounds %struct.screen_t, %struct.screen_t* %20, i32 0, i32 3
  store i32 0, i32* %gold, align 4
  %21 = load i32, i32* %level.addr, align 4
  %add17 = add nsw i32 %21, 4
  %22 = load %struct.snake_t*, %struct.snake_t** %snake.addr, align 8
  %len = getelementptr inbounds %struct.snake_t, %struct.snake_t* %22, i32 0, i32 2
  store i32 %add17, i32* %len, align 4
  %23 = load i32, i32* %level.addr, align 4
  %mul18 = mul nsw i32 %23, 10000
  %sub = sub nsw i32 200000, %mul18
  store i32 %sub, i32* @usec_delay, align 4
  store i32 0, i32* %row, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc28, %if.end16
  %24 = load i32, i32* %row, align 4
  %cmp19 = icmp slt i32 %24, 22
  br i1 %cmp19, label %for.body, label %for.end30

for.body:                                         ; preds = %for.cond
  store i32 0, i32* %col, align 4
  br label %for.cond21

for.cond21:                                       ; preds = %for.inc, %for.body
  %25 = load i32, i32* %col, align 4
  %cmp22 = icmp slt i32 %25, 78
  br i1 %cmp22, label %for.body24, label %for.end

for.body24:                                       ; preds = %for.cond21
  %26 = load %struct.screen_t*, %struct.screen_t** %screen.addr, align 8
  %grid = getelementptr inbounds %struct.screen_t, %struct.screen_t* %26, i32 0, i32 5
  %27 = load i32, i32* %row, align 4
  %idxprom = sext i32 %27 to i64
  %arrayidx = getelementptr inbounds [22 x [78 x i8]], [22 x [78 x i8]]* %grid, i64 0, i64 %idxprom
  %28 = load i32, i32* %col, align 4
  %idxprom25 = sext i32 %28 to i64
  %arrayidx26 = getelementptr inbounds [78 x i8], [78 x i8]* %arrayidx, i64 0, i64 %idxprom25
  store i8 32, i8* %arrayidx26, align 1
  br label %for.inc

for.inc:                                          ; preds = %for.body24
  %29 = load i32, i32* %col, align 4
  %inc27 = add nsw i32 %29, 1
  store i32 %inc27, i32* %col, align 4
  br label %for.cond21

for.end:                                          ; preds = %for.cond21
  br label %for.inc28

for.inc28:                                        ; preds = %for.end
  %30 = load i32, i32* %row, align 4
  %inc29 = add nsw i32 %30, 1
  store i32 %inc29, i32* %row, align 4
  br label %for.cond

for.end30:                                        ; preds = %for.cond
  store i32 0, i32* %i, align 4
  br label %for.cond31

for.cond31:                                       ; preds = %for.inc67, %for.end30
  %31 = load i32, i32* %i, align 4
  %32 = load %struct.screen_t*, %struct.screen_t** %screen.addr, align 8
  %obstacles32 = getelementptr inbounds %struct.screen_t, %struct.screen_t* %32, i32 0, i32 4
  %33 = load i32, i32* %obstacles32, align 4
  %mul33 = mul nsw i32 %33, 2
  %cmp34 = icmp slt i32 %31, %mul33
  br i1 %cmp34, label %for.body36, label %for.end69

for.body36:                                       ; preds = %for.cond31
  br label %do.body

do.body:                                          ; preds = %do.cond, %for.body36
  %call37 = call i32 @rand() #5
  %rem38 = srem i32 %call37, 22
  store i32 %rem38, i32* %row, align 4
  %call39 = call i32 @rand() #5
  %rem40 = srem i32 %call39, 78
  store i32 %rem40, i32* %col, align 4
  br label %do.cond

do.cond:                                          ; preds = %do.body
  %34 = load %struct.screen_t*, %struct.screen_t** %screen.addr, align 8
  %grid41 = getelementptr inbounds %struct.screen_t, %struct.screen_t* %34, i32 0, i32 5
  %35 = load i32, i32* %row, align 4
  %idxprom42 = sext i32 %35 to i64
  %arrayidx43 = getelementptr inbounds [22 x [78 x i8]], [22 x [78 x i8]]* %grid41, i64 0, i64 %idxprom42
  %36 = load i32, i32* %col, align 4
  %idxprom44 = sext i32 %36 to i64
  %arrayidx45 = getelementptr inbounds [78 x i8], [78 x i8]* %arrayidx43, i64 0, i64 %idxprom44
  %37 = load i8, i8* %arrayidx45, align 1
  %conv46 = sext i8 %37 to i32
  %cmp47 = icmp ne i32 %conv46, 32
  br i1 %cmp47, label %do.body, label %do.end

do.end:                                           ; preds = %do.cond
  %38 = load i32, i32* %i, align 4
  %39 = load %struct.screen_t*, %struct.screen_t** %screen.addr, align 8
  %obstacles49 = getelementptr inbounds %struct.screen_t, %struct.screen_t* %39, i32 0, i32 4
  %40 = load i32, i32* %obstacles49, align 4
  %cmp50 = icmp slt i32 %38, %40
  br i1 %cmp50, label %if.then52, label %if.else58

if.then52:                                        ; preds = %do.end
  %41 = load %struct.screen_t*, %struct.screen_t** %screen.addr, align 8
  %grid53 = getelementptr inbounds %struct.screen_t, %struct.screen_t* %41, i32 0, i32 5
  %42 = load i32, i32* %row, align 4
  %idxprom54 = sext i32 %42 to i64
  %arrayidx55 = getelementptr inbounds [22 x [78 x i8]], [22 x [78 x i8]]* %grid53, i64 0, i64 %idxprom54
  %43 = load i32, i32* %col, align 4
  %idxprom56 = sext i32 %43 to i64
  %arrayidx57 = getelementptr inbounds [78 x i8], [78 x i8]* %arrayidx55, i64 0, i64 %idxprom56
  store i8 42, i8* %arrayidx57, align 1
  br label %if.end66

if.else58:                                        ; preds = %do.end
  %44 = load %struct.screen_t*, %struct.screen_t** %screen.addr, align 8
  %gold59 = getelementptr inbounds %struct.screen_t, %struct.screen_t* %44, i32 0, i32 3
  %45 = load i32, i32* %gold59, align 4
  %inc60 = add nsw i32 %45, 1
  store i32 %inc60, i32* %gold59, align 4
  %46 = load %struct.screen_t*, %struct.screen_t** %screen.addr, align 8
  %grid61 = getelementptr inbounds %struct.screen_t, %struct.screen_t* %46, i32 0, i32 5
  %47 = load i32, i32* %row, align 4
  %idxprom62 = sext i32 %47 to i64
  %arrayidx63 = getelementptr inbounds [22 x [78 x i8]], [22 x [78 x i8]]* %grid61, i64 0, i64 %idxprom62
  %48 = load i32, i32* %col, align 4
  %idxprom64 = sext i32 %48 to i64
  %arrayidx65 = getelementptr inbounds [78 x i8], [78 x i8]* %arrayidx63, i64 0, i64 %idxprom64
  store i8 36, i8* %arrayidx65, align 1
  br label %if.end66

if.end66:                                         ; preds = %if.else58, %if.then52
  br label %for.inc67

for.inc67:                                        ; preds = %if.end66
  %49 = load i32, i32* %i, align 4
  %inc68 = add nsw i32 %49, 1
  store i32 %inc68, i32* %i, align 4
  br label %for.cond31

for.end69:                                        ; preds = %for.cond31
  store i32 0, i32* %i, align 4
  br label %for.cond70

for.cond70:                                       ; preds = %for.inc91, %for.end69
  %50 = load i32, i32* %i, align 4
  %51 = load %struct.snake_t*, %struct.snake_t** %snake.addr, align 8
  %len71 = getelementptr inbounds %struct.snake_t, %struct.snake_t* %51, i32 0, i32 2
  %52 = load i32, i32* %len71, align 4
  %cmp72 = icmp slt i32 %50, %52
  br i1 %cmp72, label %for.body74, label %for.end93

for.body74:                                       ; preds = %for.cond70
  %53 = load %struct.snake_t*, %struct.snake_t** %snake.addr, align 8
  %body = getelementptr inbounds %struct.snake_t, %struct.snake_t* %53, i32 0, i32 3
  %54 = load i32, i32* %i, align 4
  %idxprom75 = sext i32 %54 to i64
  %arrayidx76 = getelementptr inbounds [100 x %struct.snake_segment_t], [100 x %struct.snake_segment_t]* %body, i64 0, i64 %idxprom75
  %row77 = getelementptr inbounds %struct.snake_segment_t, %struct.snake_segment_t* %arrayidx76, i32 0, i32 0
  store i32 11, i32* %row77, align 4
  %55 = load %struct.snake_t*, %struct.snake_t** %snake.addr, align 8
  %dir78 = getelementptr inbounds %struct.snake_t, %struct.snake_t* %55, i32 0, i32 1
  %56 = load i32, i32* %dir78, align 4
  %cmp79 = icmp eq i32 %56, 0
  br i1 %cmp79, label %cond.true, label %cond.false

cond.true:                                        ; preds = %for.body74
  %57 = load i32, i32* %level.addr, align 4
  %add81 = add nsw i32 4, %57
  %sub82 = sub nsw i32 39, %add81
  %58 = load i32, i32* %i, align 4
  %sub83 = sub nsw i32 %sub82, %58
  br label %cond.end

cond.false:                                       ; preds = %for.body74
  %59 = load i32, i32* %level.addr, align 4
  %add84 = add nsw i32 4, %59
  %sub85 = sub nsw i32 39, %add84
  %60 = load i32, i32* %i, align 4
  %add86 = add nsw i32 %sub85, %60
  br label %cond.end

cond.end:                                         ; preds = %cond.false, %cond.true
  %cond = phi i32 [ %sub83, %cond.true ], [ %add86, %cond.false ]
  %61 = load %struct.snake_t*, %struct.snake_t** %snake.addr, align 8
  %body87 = getelementptr inbounds %struct.snake_t, %struct.snake_t* %61, i32 0, i32 3
  %62 = load i32, i32* %i, align 4
  %idxprom88 = sext i32 %62 to i64
  %arrayidx89 = getelementptr inbounds [100 x %struct.snake_segment_t], [100 x %struct.snake_segment_t]* %body87, i64 0, i64 %idxprom88
  %col90 = getelementptr inbounds %struct.snake_segment_t, %struct.snake_segment_t* %arrayidx89, i32 0, i32 1
  store i32 %cond, i32* %col90, align 4
  br label %for.inc91

for.inc91:                                        ; preds = %cond.end
  %63 = load i32, i32* %i, align 4
  %inc92 = add nsw i32 %63, 1
  store i32 %inc92, i32* %i, align 4
  br label %for.cond70

for.end93:                                        ; preds = %for.cond70
  %call94 = call i32 @puts(i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str, i32 0, i32 0))
  call void @draw_line(i32 1, i32 1)
  store i32 0, i32* %row, align 4
  br label %for.cond95

for.cond95:                                       ; preds = %for.inc124, %for.end93
  %64 = load i32, i32* %row, align 4
  %cmp96 = icmp slt i32 %64, 22
  br i1 %cmp96, label %for.body98, label %for.end126

for.body98:                                       ; preds = %for.cond95
  %65 = load i32, i32* %row, align 4
  %add99 = add nsw i32 %65, 2
  %call100 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([9 x i8], [9 x i8]* @.str.3, i32 0, i32 0), i32 %add99, i32 1)
  %call101 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([9 x i8], [9 x i8]* @.str.2, i32 0, i32 0), i32 1, i32 34)
  %call102 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([9 x i8], [9 x i8]* @.str.2, i32 0, i32 0), i32 1, i32 44)
  %call103 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.11, i32 0, i32 0))
  %call104 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.10, i32 0, i32 0), i32 0)
  %call105 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([9 x i8], [9 x i8]* @.str.2, i32 0, i32 0), i32 1, i32 37)
  store i32 0, i32* %col, align 4
  br label %for.cond106

for.cond106:                                      ; preds = %for.inc117, %for.body98
  %66 = load i32, i32* %col, align 4
  %cmp107 = icmp slt i32 %66, 78
  br i1 %cmp107, label %for.body109, label %for.end119

for.body109:                                      ; preds = %for.cond106
  %67 = load %struct.screen_t*, %struct.screen_t** %screen.addr, align 8
  %grid110 = getelementptr inbounds %struct.screen_t, %struct.screen_t* %67, i32 0, i32 5
  %68 = load i32, i32* %row, align 4
  %idxprom111 = sext i32 %68 to i64
  %arrayidx112 = getelementptr inbounds [22 x [78 x i8]], [22 x [78 x i8]]* %grid110, i64 0, i64 %idxprom111
  %69 = load i32, i32* %col, align 4
  %idxprom113 = sext i32 %69 to i64
  %arrayidx114 = getelementptr inbounds [78 x i8], [78 x i8]* %arrayidx112, i64 0, i64 %idxprom113
  %70 = load i8, i8* %arrayidx114, align 1
  %conv115 = sext i8 %70 to i32
  %call116 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.12, i32 0, i32 0), i32 %conv115)
  br label %for.inc117

for.inc117:                                       ; preds = %for.body109
  %71 = load i32, i32* %col, align 4
  %inc118 = add nsw i32 %71, 1
  store i32 %inc118, i32* %col, align 4
  br label %for.cond106

for.end119:                                       ; preds = %for.cond106
  %call120 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([9 x i8], [9 x i8]* @.str.2, i32 0, i32 0), i32 1, i32 34)
  %call121 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([9 x i8], [9 x i8]* @.str.2, i32 0, i32 0), i32 1, i32 44)
  %call122 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.11, i32 0, i32 0))
  %call123 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.10, i32 0, i32 0), i32 0)
  br label %for.inc124

for.inc124:                                       ; preds = %for.end119
  %72 = load i32, i32* %row, align 4
  %inc125 = add nsw i32 %72, 1
  store i32 %inc125, i32* %row, align 4
  br label %for.cond95

for.end126:                                       ; preds = %for.cond95
  call void @draw_line(i32 1, i32 24)
  %73 = load %struct.screen_t*, %struct.screen_t** %screen.addr, align 8
  call void @show_score(%struct.screen_t* %73)
  %call127 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([9 x i8], [9 x i8]* @.str.2, i32 0, i32 0), i32 1, i32 31)
  %call128 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([9 x i8], [9 x i8]* @.str.3, i32 0, i32 0), i32 1, i32 30)
  ret void
}

; Function Attrs: nounwind
declare void @srand(i32) #1

; Function Attrs: nounwind
declare i64 @time(i64*) #1

; Function Attrs: nounwind
declare i32 @rand() #1

; Function Attrs: noinline nounwind optnone uwtable
define void @move(%struct.snake_t* %snake, i8* %keys, i8 signext %key) #0 {
entry:
  %snake.addr = alloca %struct.snake_t*, align 8
  %keys.addr = alloca i8*, align 8
  %key.addr = alloca i8, align 1
  %i = alloca i32, align 4
  %prev = alloca i32, align 4
  store %struct.snake_t* %snake, %struct.snake_t** %snake.addr, align 8
  store i8* %keys, i8** %keys.addr, align 8
  store i8 %key, i8* %key.addr, align 1
  %0 = load %struct.snake_t*, %struct.snake_t** %snake.addr, align 8
  %dir = getelementptr inbounds %struct.snake_t, %struct.snake_t* %0, i32 0, i32 1
  %1 = load i32, i32* %dir, align 4
  store i32 %1, i32* %prev, align 4
  %2 = load i8, i8* %key.addr, align 1
  %conv = sext i8 %2 to i32
  %3 = load i8*, i8** %keys.addr, align 8
  %arrayidx = getelementptr inbounds i8, i8* %3, i64 1
  %4 = load i8, i8* %arrayidx, align 1
  %conv1 = sext i8 %4 to i32
  %cmp = icmp eq i32 %conv, %conv1
  br i1 %cmp, label %if.then, label %if.else

if.then:                                          ; preds = %entry
  %5 = load %struct.snake_t*, %struct.snake_t** %snake.addr, align 8
  %dir3 = getelementptr inbounds %struct.snake_t, %struct.snake_t* %5, i32 0, i32 1
  store i32 1, i32* %dir3, align 4
  br label %if.end62

if.else:                                          ; preds = %entry
  %6 = load i8, i8* %key.addr, align 1
  %conv4 = sext i8 %6 to i32
  %7 = load i8*, i8** %keys.addr, align 8
  %arrayidx5 = getelementptr inbounds i8, i8* %7, i64 0
  %8 = load i8, i8* %arrayidx5, align 1
  %conv6 = sext i8 %8 to i32
  %cmp7 = icmp eq i32 %conv4, %conv6
  br i1 %cmp7, label %if.then9, label %if.else11

if.then9:                                         ; preds = %if.else
  %9 = load %struct.snake_t*, %struct.snake_t** %snake.addr, align 8
  %dir10 = getelementptr inbounds %struct.snake_t, %struct.snake_t* %9, i32 0, i32 1
  store i32 0, i32* %dir10, align 4
  br label %if.end61

if.else11:                                        ; preds = %if.else
  %10 = load i8, i8* %key.addr, align 1
  %conv12 = sext i8 %10 to i32
  %11 = load i8*, i8** %keys.addr, align 8
  %arrayidx13 = getelementptr inbounds i8, i8* %11, i64 2
  %12 = load i8, i8* %arrayidx13, align 1
  %conv14 = sext i8 %12 to i32
  %cmp15 = icmp eq i32 %conv12, %conv14
  br i1 %cmp15, label %if.then17, label %if.else19

if.then17:                                        ; preds = %if.else11
  %13 = load %struct.snake_t*, %struct.snake_t** %snake.addr, align 8
  %dir18 = getelementptr inbounds %struct.snake_t, %struct.snake_t* %13, i32 0, i32 1
  store i32 2, i32* %dir18, align 4
  br label %if.end60

if.else19:                                        ; preds = %if.else11
  %14 = load i8, i8* %key.addr, align 1
  %conv20 = sext i8 %14 to i32
  %15 = load i8*, i8** %keys.addr, align 8
  %arrayidx21 = getelementptr inbounds i8, i8* %15, i64 3
  %16 = load i8, i8* %arrayidx21, align 1
  %conv22 = sext i8 %16 to i32
  %cmp23 = icmp eq i32 %conv20, %conv22
  br i1 %cmp23, label %if.then25, label %if.else27

if.then25:                                        ; preds = %if.else19
  %17 = load %struct.snake_t*, %struct.snake_t** %snake.addr, align 8
  %dir26 = getelementptr inbounds %struct.snake_t, %struct.snake_t* %17, i32 0, i32 1
  store i32 3, i32* %dir26, align 4
  br label %if.end59

if.else27:                                        ; preds = %if.else19
  %18 = load i8, i8* %key.addr, align 1
  %conv28 = sext i8 %18 to i32
  %19 = load i8*, i8** %keys.addr, align 8
  %arrayidx29 = getelementptr inbounds i8, i8* %19, i64 4
  %20 = load i8, i8* %arrayidx29, align 1
  %conv30 = sext i8 %20 to i32
  %cmp31 = icmp eq i32 %conv28, %conv30
  br i1 %cmp31, label %if.then33, label %if.else41

if.then33:                                        ; preds = %if.else27
  %21 = load i32, i32* %prev, align 4
  switch i32 %21, label %sw.default [
    i32 0, label %sw.bb
    i32 1, label %sw.bb35
    i32 2, label %sw.bb37
    i32 3, label %sw.bb39
  ]

sw.bb:                                            ; preds = %if.then33
  %22 = load %struct.snake_t*, %struct.snake_t** %snake.addr, align 8
  %dir34 = getelementptr inbounds %struct.snake_t, %struct.snake_t* %22, i32 0, i32 1
  store i32 3, i32* %dir34, align 4
  br label %sw.epilog

sw.bb35:                                          ; preds = %if.then33
  %23 = load %struct.snake_t*, %struct.snake_t** %snake.addr, align 8
  %dir36 = getelementptr inbounds %struct.snake_t, %struct.snake_t* %23, i32 0, i32 1
  store i32 2, i32* %dir36, align 4
  br label %sw.epilog

sw.bb37:                                          ; preds = %if.then33
  %24 = load %struct.snake_t*, %struct.snake_t** %snake.addr, align 8
  %dir38 = getelementptr inbounds %struct.snake_t, %struct.snake_t* %24, i32 0, i32 1
  store i32 0, i32* %dir38, align 4
  br label %sw.epilog

sw.bb39:                                          ; preds = %if.then33
  %25 = load %struct.snake_t*, %struct.snake_t** %snake.addr, align 8
  %dir40 = getelementptr inbounds %struct.snake_t, %struct.snake_t* %25, i32 0, i32 1
  store i32 1, i32* %dir40, align 4
  br label %sw.epilog

sw.default:                                       ; preds = %if.then33
  br label %sw.epilog

sw.epilog:                                        ; preds = %sw.default, %sw.bb39, %sw.bb37, %sw.bb35, %sw.bb
  br label %if.end58

if.else41:                                        ; preds = %if.else27
  %26 = load i8, i8* %key.addr, align 1
  %conv42 = sext i8 %26 to i32
  %27 = load i8*, i8** %keys.addr, align 8
  %arrayidx43 = getelementptr inbounds i8, i8* %27, i64 5
  %28 = load i8, i8* %arrayidx43, align 1
  %conv44 = sext i8 %28 to i32
  %cmp45 = icmp eq i32 %conv42, %conv44
  br i1 %cmp45, label %if.then47, label %if.end

if.then47:                                        ; preds = %if.else41
  %29 = load i32, i32* %prev, align 4
  switch i32 %29, label %sw.default56 [
    i32 0, label %sw.bb48
    i32 1, label %sw.bb50
    i32 2, label %sw.bb52
    i32 3, label %sw.bb54
  ]

sw.bb48:                                          ; preds = %if.then47
  %30 = load %struct.snake_t*, %struct.snake_t** %snake.addr, align 8
  %dir49 = getelementptr inbounds %struct.snake_t, %struct.snake_t* %30, i32 0, i32 1
  store i32 2, i32* %dir49, align 4
  br label %sw.epilog57

sw.bb50:                                          ; preds = %if.then47
  %31 = load %struct.snake_t*, %struct.snake_t** %snake.addr, align 8
  %dir51 = getelementptr inbounds %struct.snake_t, %struct.snake_t* %31, i32 0, i32 1
  store i32 3, i32* %dir51, align 4
  br label %sw.epilog57

sw.bb52:                                          ; preds = %if.then47
  %32 = load %struct.snake_t*, %struct.snake_t** %snake.addr, align 8
  %dir53 = getelementptr inbounds %struct.snake_t, %struct.snake_t* %32, i32 0, i32 1
  store i32 1, i32* %dir53, align 4
  br label %sw.epilog57

sw.bb54:                                          ; preds = %if.then47
  %33 = load %struct.snake_t*, %struct.snake_t** %snake.addr, align 8
  %dir55 = getelementptr inbounds %struct.snake_t, %struct.snake_t* %33, i32 0, i32 1
  store i32 0, i32* %dir55, align 4
  br label %sw.epilog57

sw.default56:                                     ; preds = %if.then47
  br label %sw.epilog57

sw.epilog57:                                      ; preds = %sw.default56, %sw.bb54, %sw.bb52, %sw.bb50, %sw.bb48
  br label %if.end

if.end:                                           ; preds = %sw.epilog57, %if.else41
  br label %if.end58

if.end58:                                         ; preds = %if.end, %sw.epilog
  br label %if.end59

if.end59:                                         ; preds = %if.end58, %if.then25
  br label %if.end60

if.end60:                                         ; preds = %if.end59, %if.then17
  br label %if.end61

if.end61:                                         ; preds = %if.end60, %if.then9
  br label %if.end62

if.end62:                                         ; preds = %if.end61, %if.then
  %34 = load %struct.snake_t*, %struct.snake_t** %snake.addr, align 8
  %dir63 = getelementptr inbounds %struct.snake_t, %struct.snake_t* %34, i32 0, i32 1
  %35 = load i32, i32* %dir63, align 4
  switch i32 %35, label %sw.default153 [
    i32 0, label %sw.bb64
    i32 1, label %sw.bb82
    i32 2, label %sw.bb105
    i32 3, label %sw.bb129
  ]

sw.bb64:                                          ; preds = %if.end62
  %36 = load %struct.snake_t*, %struct.snake_t** %snake.addr, align 8
  %body = getelementptr inbounds %struct.snake_t, %struct.snake_t* %36, i32 0, i32 3
  %37 = load %struct.snake_t*, %struct.snake_t** %snake.addr, align 8
  %len = getelementptr inbounds %struct.snake_t, %struct.snake_t* %37, i32 0, i32 2
  %38 = load i32, i32* %len, align 4
  %sub = sub nsw i32 %38, 1
  %idxprom = sext i32 %sub to i64
  %arrayidx65 = getelementptr inbounds [100 x %struct.snake_segment_t], [100 x %struct.snake_segment_t]* %body, i64 0, i64 %idxprom
  %row = getelementptr inbounds %struct.snake_segment_t, %struct.snake_segment_t* %arrayidx65, i32 0, i32 0
  %39 = load i32, i32* %row, align 4
  %40 = load %struct.snake_t*, %struct.snake_t** %snake.addr, align 8
  %body66 = getelementptr inbounds %struct.snake_t, %struct.snake_t* %40, i32 0, i32 3
  %41 = load %struct.snake_t*, %struct.snake_t** %snake.addr, align 8
  %len67 = getelementptr inbounds %struct.snake_t, %struct.snake_t* %41, i32 0, i32 2
  %42 = load i32, i32* %len67, align 4
  %idxprom68 = sext i32 %42 to i64
  %arrayidx69 = getelementptr inbounds [100 x %struct.snake_segment_t], [100 x %struct.snake_segment_t]* %body66, i64 0, i64 %idxprom68
  %row70 = getelementptr inbounds %struct.snake_segment_t, %struct.snake_segment_t* %arrayidx69, i32 0, i32 0
  store i32 %39, i32* %row70, align 4
  %43 = load %struct.snake_t*, %struct.snake_t** %snake.addr, align 8
  %body71 = getelementptr inbounds %struct.snake_t, %struct.snake_t* %43, i32 0, i32 3
  %44 = load %struct.snake_t*, %struct.snake_t** %snake.addr, align 8
  %len72 = getelementptr inbounds %struct.snake_t, %struct.snake_t* %44, i32 0, i32 2
  %45 = load i32, i32* %len72, align 4
  %sub73 = sub nsw i32 %45, 1
  %idxprom74 = sext i32 %sub73 to i64
  %arrayidx75 = getelementptr inbounds [100 x %struct.snake_segment_t], [100 x %struct.snake_segment_t]* %body71, i64 0, i64 %idxprom74
  %col = getelementptr inbounds %struct.snake_segment_t, %struct.snake_segment_t* %arrayidx75, i32 0, i32 1
  %46 = load i32, i32* %col, align 4
  %sub76 = sub nsw i32 %46, 1
  %47 = load %struct.snake_t*, %struct.snake_t** %snake.addr, align 8
  %body77 = getelementptr inbounds %struct.snake_t, %struct.snake_t* %47, i32 0, i32 3
  %48 = load %struct.snake_t*, %struct.snake_t** %snake.addr, align 8
  %len78 = getelementptr inbounds %struct.snake_t, %struct.snake_t* %48, i32 0, i32 2
  %49 = load i32, i32* %len78, align 4
  %idxprom79 = sext i32 %49 to i64
  %arrayidx80 = getelementptr inbounds [100 x %struct.snake_segment_t], [100 x %struct.snake_segment_t]* %body77, i64 0, i64 %idxprom79
  %col81 = getelementptr inbounds %struct.snake_segment_t, %struct.snake_segment_t* %arrayidx80, i32 0, i32 1
  store i32 %sub76, i32* %col81, align 4
  br label %sw.epilog154

sw.bb82:                                          ; preds = %if.end62
  %50 = load %struct.snake_t*, %struct.snake_t** %snake.addr, align 8
  %body83 = getelementptr inbounds %struct.snake_t, %struct.snake_t* %50, i32 0, i32 3
  %51 = load %struct.snake_t*, %struct.snake_t** %snake.addr, align 8
  %len84 = getelementptr inbounds %struct.snake_t, %struct.snake_t* %51, i32 0, i32 2
  %52 = load i32, i32* %len84, align 4
  %sub85 = sub nsw i32 %52, 1
  %idxprom86 = sext i32 %sub85 to i64
  %arrayidx87 = getelementptr inbounds [100 x %struct.snake_segment_t], [100 x %struct.snake_segment_t]* %body83, i64 0, i64 %idxprom86
  %row88 = getelementptr inbounds %struct.snake_segment_t, %struct.snake_segment_t* %arrayidx87, i32 0, i32 0
  %53 = load i32, i32* %row88, align 4
  %54 = load %struct.snake_t*, %struct.snake_t** %snake.addr, align 8
  %body89 = getelementptr inbounds %struct.snake_t, %struct.snake_t* %54, i32 0, i32 3
  %55 = load %struct.snake_t*, %struct.snake_t** %snake.addr, align 8
  %len90 = getelementptr inbounds %struct.snake_t, %struct.snake_t* %55, i32 0, i32 2
  %56 = load i32, i32* %len90, align 4
  %idxprom91 = sext i32 %56 to i64
  %arrayidx92 = getelementptr inbounds [100 x %struct.snake_segment_t], [100 x %struct.snake_segment_t]* %body89, i64 0, i64 %idxprom91
  %row93 = getelementptr inbounds %struct.snake_segment_t, %struct.snake_segment_t* %arrayidx92, i32 0, i32 0
  store i32 %53, i32* %row93, align 4
  %57 = load %struct.snake_t*, %struct.snake_t** %snake.addr, align 8
  %body94 = getelementptr inbounds %struct.snake_t, %struct.snake_t* %57, i32 0, i32 3
  %58 = load %struct.snake_t*, %struct.snake_t** %snake.addr, align 8
  %len95 = getelementptr inbounds %struct.snake_t, %struct.snake_t* %58, i32 0, i32 2
  %59 = load i32, i32* %len95, align 4
  %sub96 = sub nsw i32 %59, 1
  %idxprom97 = sext i32 %sub96 to i64
  %arrayidx98 = getelementptr inbounds [100 x %struct.snake_segment_t], [100 x %struct.snake_segment_t]* %body94, i64 0, i64 %idxprom97
  %col99 = getelementptr inbounds %struct.snake_segment_t, %struct.snake_segment_t* %arrayidx98, i32 0, i32 1
  %60 = load i32, i32* %col99, align 4
  %add = add nsw i32 %60, 1
  %61 = load %struct.snake_t*, %struct.snake_t** %snake.addr, align 8
  %body100 = getelementptr inbounds %struct.snake_t, %struct.snake_t* %61, i32 0, i32 3
  %62 = load %struct.snake_t*, %struct.snake_t** %snake.addr, align 8
  %len101 = getelementptr inbounds %struct.snake_t, %struct.snake_t* %62, i32 0, i32 2
  %63 = load i32, i32* %len101, align 4
  %idxprom102 = sext i32 %63 to i64
  %arrayidx103 = getelementptr inbounds [100 x %struct.snake_segment_t], [100 x %struct.snake_segment_t]* %body100, i64 0, i64 %idxprom102
  %col104 = getelementptr inbounds %struct.snake_segment_t, %struct.snake_segment_t* %arrayidx103, i32 0, i32 1
  store i32 %add, i32* %col104, align 4
  br label %sw.epilog154

sw.bb105:                                         ; preds = %if.end62
  %64 = load %struct.snake_t*, %struct.snake_t** %snake.addr, align 8
  %body106 = getelementptr inbounds %struct.snake_t, %struct.snake_t* %64, i32 0, i32 3
  %65 = load %struct.snake_t*, %struct.snake_t** %snake.addr, align 8
  %len107 = getelementptr inbounds %struct.snake_t, %struct.snake_t* %65, i32 0, i32 2
  %66 = load i32, i32* %len107, align 4
  %sub108 = sub nsw i32 %66, 1
  %idxprom109 = sext i32 %sub108 to i64
  %arrayidx110 = getelementptr inbounds [100 x %struct.snake_segment_t], [100 x %struct.snake_segment_t]* %body106, i64 0, i64 %idxprom109
  %row111 = getelementptr inbounds %struct.snake_segment_t, %struct.snake_segment_t* %arrayidx110, i32 0, i32 0
  %67 = load i32, i32* %row111, align 4
  %sub112 = sub nsw i32 %67, 1
  %68 = load %struct.snake_t*, %struct.snake_t** %snake.addr, align 8
  %body113 = getelementptr inbounds %struct.snake_t, %struct.snake_t* %68, i32 0, i32 3
  %69 = load %struct.snake_t*, %struct.snake_t** %snake.addr, align 8
  %len114 = getelementptr inbounds %struct.snake_t, %struct.snake_t* %69, i32 0, i32 2
  %70 = load i32, i32* %len114, align 4
  %idxprom115 = sext i32 %70 to i64
  %arrayidx116 = getelementptr inbounds [100 x %struct.snake_segment_t], [100 x %struct.snake_segment_t]* %body113, i64 0, i64 %idxprom115
  %row117 = getelementptr inbounds %struct.snake_segment_t, %struct.snake_segment_t* %arrayidx116, i32 0, i32 0
  store i32 %sub112, i32* %row117, align 4
  %71 = load %struct.snake_t*, %struct.snake_t** %snake.addr, align 8
  %body118 = getelementptr inbounds %struct.snake_t, %struct.snake_t* %71, i32 0, i32 3
  %72 = load %struct.snake_t*, %struct.snake_t** %snake.addr, align 8
  %len119 = getelementptr inbounds %struct.snake_t, %struct.snake_t* %72, i32 0, i32 2
  %73 = load i32, i32* %len119, align 4
  %sub120 = sub nsw i32 %73, 1
  %idxprom121 = sext i32 %sub120 to i64
  %arrayidx122 = getelementptr inbounds [100 x %struct.snake_segment_t], [100 x %struct.snake_segment_t]* %body118, i64 0, i64 %idxprom121
  %col123 = getelementptr inbounds %struct.snake_segment_t, %struct.snake_segment_t* %arrayidx122, i32 0, i32 1
  %74 = load i32, i32* %col123, align 4
  %75 = load %struct.snake_t*, %struct.snake_t** %snake.addr, align 8
  %body124 = getelementptr inbounds %struct.snake_t, %struct.snake_t* %75, i32 0, i32 3
  %76 = load %struct.snake_t*, %struct.snake_t** %snake.addr, align 8
  %len125 = getelementptr inbounds %struct.snake_t, %struct.snake_t* %76, i32 0, i32 2
  %77 = load i32, i32* %len125, align 4
  %idxprom126 = sext i32 %77 to i64
  %arrayidx127 = getelementptr inbounds [100 x %struct.snake_segment_t], [100 x %struct.snake_segment_t]* %body124, i64 0, i64 %idxprom126
  %col128 = getelementptr inbounds %struct.snake_segment_t, %struct.snake_segment_t* %arrayidx127, i32 0, i32 1
  store i32 %74, i32* %col128, align 4
  br label %sw.epilog154

sw.bb129:                                         ; preds = %if.end62
  %78 = load %struct.snake_t*, %struct.snake_t** %snake.addr, align 8
  %body130 = getelementptr inbounds %struct.snake_t, %struct.snake_t* %78, i32 0, i32 3
  %79 = load %struct.snake_t*, %struct.snake_t** %snake.addr, align 8
  %len131 = getelementptr inbounds %struct.snake_t, %struct.snake_t* %79, i32 0, i32 2
  %80 = load i32, i32* %len131, align 4
  %sub132 = sub nsw i32 %80, 1
  %idxprom133 = sext i32 %sub132 to i64
  %arrayidx134 = getelementptr inbounds [100 x %struct.snake_segment_t], [100 x %struct.snake_segment_t]* %body130, i64 0, i64 %idxprom133
  %row135 = getelementptr inbounds %struct.snake_segment_t, %struct.snake_segment_t* %arrayidx134, i32 0, i32 0
  %81 = load i32, i32* %row135, align 4
  %add136 = add nsw i32 %81, 1
  %82 = load %struct.snake_t*, %struct.snake_t** %snake.addr, align 8
  %body137 = getelementptr inbounds %struct.snake_t, %struct.snake_t* %82, i32 0, i32 3
  %83 = load %struct.snake_t*, %struct.snake_t** %snake.addr, align 8
  %len138 = getelementptr inbounds %struct.snake_t, %struct.snake_t* %83, i32 0, i32 2
  %84 = load i32, i32* %len138, align 4
  %idxprom139 = sext i32 %84 to i64
  %arrayidx140 = getelementptr inbounds [100 x %struct.snake_segment_t], [100 x %struct.snake_segment_t]* %body137, i64 0, i64 %idxprom139
  %row141 = getelementptr inbounds %struct.snake_segment_t, %struct.snake_segment_t* %arrayidx140, i32 0, i32 0
  store i32 %add136, i32* %row141, align 4
  %85 = load %struct.snake_t*, %struct.snake_t** %snake.addr, align 8
  %body142 = getelementptr inbounds %struct.snake_t, %struct.snake_t* %85, i32 0, i32 3
  %86 = load %struct.snake_t*, %struct.snake_t** %snake.addr, align 8
  %len143 = getelementptr inbounds %struct.snake_t, %struct.snake_t* %86, i32 0, i32 2
  %87 = load i32, i32* %len143, align 4
  %sub144 = sub nsw i32 %87, 1
  %idxprom145 = sext i32 %sub144 to i64
  %arrayidx146 = getelementptr inbounds [100 x %struct.snake_segment_t], [100 x %struct.snake_segment_t]* %body142, i64 0, i64 %idxprom145
  %col147 = getelementptr inbounds %struct.snake_segment_t, %struct.snake_segment_t* %arrayidx146, i32 0, i32 1
  %88 = load i32, i32* %col147, align 4
  %89 = load %struct.snake_t*, %struct.snake_t** %snake.addr, align 8
  %body148 = getelementptr inbounds %struct.snake_t, %struct.snake_t* %89, i32 0, i32 3
  %90 = load %struct.snake_t*, %struct.snake_t** %snake.addr, align 8
  %len149 = getelementptr inbounds %struct.snake_t, %struct.snake_t* %90, i32 0, i32 2
  %91 = load i32, i32* %len149, align 4
  %idxprom150 = sext i32 %91 to i64
  %arrayidx151 = getelementptr inbounds [100 x %struct.snake_segment_t], [100 x %struct.snake_segment_t]* %body148, i64 0, i64 %idxprom150
  %col152 = getelementptr inbounds %struct.snake_segment_t, %struct.snake_segment_t* %arrayidx151, i32 0, i32 1
  store i32 %88, i32* %col152, align 4
  br label %sw.epilog154

sw.default153:                                    ; preds = %if.end62
  br label %sw.epilog154

sw.epilog154:                                     ; preds = %sw.default153, %sw.bb129, %sw.bb105, %sw.bb82, %sw.bb64
  %call = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.10, i32 0, i32 0), i32 0)
  %92 = load %struct.snake_t*, %struct.snake_t** %snake.addr, align 8
  %body155 = getelementptr inbounds %struct.snake_t, %struct.snake_t* %92, i32 0, i32 3
  %arrayidx156 = getelementptr inbounds [100 x %struct.snake_segment_t], [100 x %struct.snake_segment_t]* %body155, i64 0, i64 0
  %row157 = getelementptr inbounds %struct.snake_segment_t, %struct.snake_segment_t* %arrayidx156, i32 0, i32 0
  %93 = load i32, i32* %row157, align 4
  %add158 = add nsw i32 %93, 1
  %94 = load %struct.snake_t*, %struct.snake_t** %snake.addr, align 8
  %body159 = getelementptr inbounds %struct.snake_t, %struct.snake_t* %94, i32 0, i32 3
  %arrayidx160 = getelementptr inbounds [100 x %struct.snake_segment_t], [100 x %struct.snake_segment_t]* %body159, i64 0, i64 0
  %col161 = getelementptr inbounds %struct.snake_segment_t, %struct.snake_segment_t* %arrayidx160, i32 0, i32 1
  %95 = load i32, i32* %col161, align 4
  %add162 = add nsw i32 %95, 1
  %call163 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([9 x i8], [9 x i8]* @.str.3, i32 0, i32 0), i32 %add158, i32 %add162)
  %call164 = call i32 @puts(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.13, i32 0, i32 0))
  store i32 1, i32* %i, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %sw.epilog154
  %96 = load i32, i32* %i, align 4
  %97 = load %struct.snake_t*, %struct.snake_t** %snake.addr, align 8
  %len165 = getelementptr inbounds %struct.snake_t, %struct.snake_t* %97, i32 0, i32 2
  %98 = load i32, i32* %len165, align 4
  %cmp166 = icmp sle i32 %96, %98
  br i1 %cmp166, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %99 = load %struct.snake_t*, %struct.snake_t** %snake.addr, align 8
  %body168 = getelementptr inbounds %struct.snake_t, %struct.snake_t* %99, i32 0, i32 3
  %100 = load i32, i32* %i, align 4
  %sub169 = sub nsw i32 %100, 1
  %idxprom170 = sext i32 %sub169 to i64
  %arrayidx171 = getelementptr inbounds [100 x %struct.snake_segment_t], [100 x %struct.snake_segment_t]* %body168, i64 0, i64 %idxprom170
  %101 = load %struct.snake_t*, %struct.snake_t** %snake.addr, align 8
  %body172 = getelementptr inbounds %struct.snake_t, %struct.snake_t* %101, i32 0, i32 3
  %102 = load i32, i32* %i, align 4
  %idxprom173 = sext i32 %102 to i64
  %arrayidx174 = getelementptr inbounds [100 x %struct.snake_segment_t], [100 x %struct.snake_segment_t]* %body172, i64 0, i64 %idxprom173
  %103 = bitcast %struct.snake_segment_t* %arrayidx171 to i8*
  %104 = bitcast %struct.snake_segment_t* %arrayidx174 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %103, i8* %104, i64 8, i32 4, i1 false)
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %105 = load i32, i32* %i, align 4
  %inc = add nsw i32 %105, 1
  store i32 %inc, i32* %i, align 4
  br label %for.cond

for.end:                                          ; preds = %for.cond
  %call175 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([9 x i8], [9 x i8]* @.str.2, i32 0, i32 0), i32 1, i32 43)
  store i32 0, i32* %i, align 4
  br label %for.cond176

for.cond176:                                      ; preds = %for.inc193, %for.end
  %106 = load i32, i32* %i, align 4
  %107 = load %struct.snake_t*, %struct.snake_t** %snake.addr, align 8
  %len177 = getelementptr inbounds %struct.snake_t, %struct.snake_t* %107, i32 0, i32 2
  %108 = load i32, i32* %len177, align 4
  %cmp178 = icmp slt i32 %106, %108
  br i1 %cmp178, label %for.body180, label %for.end195

for.body180:                                      ; preds = %for.cond176
  %109 = load %struct.snake_t*, %struct.snake_t** %snake.addr, align 8
  %body181 = getelementptr inbounds %struct.snake_t, %struct.snake_t* %109, i32 0, i32 3
  %110 = load i32, i32* %i, align 4
  %idxprom182 = sext i32 %110 to i64
  %arrayidx183 = getelementptr inbounds [100 x %struct.snake_segment_t], [100 x %struct.snake_segment_t]* %body181, i64 0, i64 %idxprom182
  %row184 = getelementptr inbounds %struct.snake_segment_t, %struct.snake_segment_t* %arrayidx183, i32 0, i32 0
  %111 = load i32, i32* %row184, align 4
  %add185 = add nsw i32 %111, 1
  %112 = load %struct.snake_t*, %struct.snake_t** %snake.addr, align 8
  %body186 = getelementptr inbounds %struct.snake_t, %struct.snake_t* %112, i32 0, i32 3
  %113 = load i32, i32* %i, align 4
  %idxprom187 = sext i32 %113 to i64
  %arrayidx188 = getelementptr inbounds [100 x %struct.snake_segment_t], [100 x %struct.snake_segment_t]* %body186, i64 0, i64 %idxprom187
  %col189 = getelementptr inbounds %struct.snake_segment_t, %struct.snake_segment_t* %arrayidx188, i32 0, i32 1
  %114 = load i32, i32* %col189, align 4
  %add190 = add nsw i32 %114, 1
  %call191 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([9 x i8], [9 x i8]* @.str.3, i32 0, i32 0), i32 %add185, i32 %add190)
  %call192 = call i32 @puts(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.13, i32 0, i32 0))
  br label %for.inc193

for.inc193:                                       ; preds = %for.body180
  %115 = load i32, i32* %i, align 4
  %inc194 = add nsw i32 %115, 1
  store i32 %inc194, i32* %i, align 4
  br label %for.cond176

for.end195:                                       ; preds = %for.cond176
  %call196 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.10, i32 0, i32 0), i32 0)
  ret void
}

; Function Attrs: argmemonly nounwind
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* nocapture writeonly, i8* nocapture readonly, i64, i32, i1) #4

; Function Attrs: noinline nounwind optnone uwtable
define i32 @collide_walls(%struct.snake_t* %snake) #0 {
entry:
  %retval = alloca i32, align 4
  %snake.addr = alloca %struct.snake_t*, align 8
  %head = alloca %struct.snake_segment_t*, align 8
  store %struct.snake_t* %snake, %struct.snake_t** %snake.addr, align 8
  %0 = load %struct.snake_t*, %struct.snake_t** %snake.addr, align 8
  %body = getelementptr inbounds %struct.snake_t, %struct.snake_t* %0, i32 0, i32 3
  %1 = load %struct.snake_t*, %struct.snake_t** %snake.addr, align 8
  %len = getelementptr inbounds %struct.snake_t, %struct.snake_t* %1, i32 0, i32 2
  %2 = load i32, i32* %len, align 4
  %sub = sub nsw i32 %2, 1
  %idxprom = sext i32 %sub to i64
  %arrayidx = getelementptr inbounds [100 x %struct.snake_segment_t], [100 x %struct.snake_segment_t]* %body, i64 0, i64 %idxprom
  store %struct.snake_segment_t* %arrayidx, %struct.snake_segment_t** %head, align 8
  %3 = load %struct.snake_segment_t*, %struct.snake_segment_t** %head, align 8
  %row = getelementptr inbounds %struct.snake_segment_t, %struct.snake_segment_t* %3, i32 0, i32 0
  %4 = load i32, i32* %row, align 4
  %cmp = icmp sgt i32 %4, 22
  br i1 %cmp, label %if.then, label %lor.lhs.false

lor.lhs.false:                                    ; preds = %entry
  %5 = load %struct.snake_segment_t*, %struct.snake_segment_t** %head, align 8
  %row1 = getelementptr inbounds %struct.snake_segment_t, %struct.snake_segment_t* %5, i32 0, i32 0
  %6 = load i32, i32* %row1, align 4
  %cmp2 = icmp slt i32 %6, 1
  br i1 %cmp2, label %if.then, label %lor.lhs.false3

lor.lhs.false3:                                   ; preds = %lor.lhs.false
  %7 = load %struct.snake_segment_t*, %struct.snake_segment_t** %head, align 8
  %col = getelementptr inbounds %struct.snake_segment_t, %struct.snake_segment_t* %7, i32 0, i32 1
  %8 = load i32, i32* %col, align 4
  %cmp4 = icmp sgt i32 %8, 78
  br i1 %cmp4, label %if.then, label %lor.lhs.false5

lor.lhs.false5:                                   ; preds = %lor.lhs.false3
  %9 = load %struct.snake_segment_t*, %struct.snake_segment_t** %head, align 8
  %col6 = getelementptr inbounds %struct.snake_segment_t, %struct.snake_segment_t* %9, i32 0, i32 1
  %10 = load i32, i32* %col6, align 4
  %cmp7 = icmp slt i32 %10, 1
  br i1 %cmp7, label %if.then, label %if.end

if.then:                                          ; preds = %lor.lhs.false5, %lor.lhs.false3, %lor.lhs.false, %entry
  store i32 1, i32* %retval, align 4
  br label %return

if.end:                                           ; preds = %lor.lhs.false5
  store i32 0, i32* %retval, align 4
  br label %return

return:                                           ; preds = %if.end, %if.then
  %11 = load i32, i32* %retval, align 4
  ret i32 %11
}

; Function Attrs: noinline nounwind optnone uwtable
define i32 @collide_object(%struct.snake_t* %snake, %struct.screen_t* %screen, i8 signext %object) #0 {
entry:
  %retval = alloca i32, align 4
  %snake.addr = alloca %struct.snake_t*, align 8
  %screen.addr = alloca %struct.screen_t*, align 8
  %object.addr = alloca i8, align 1
  %head = alloca %struct.snake_segment_t*, align 8
  store %struct.snake_t* %snake, %struct.snake_t** %snake.addr, align 8
  store %struct.screen_t* %screen, %struct.screen_t** %screen.addr, align 8
  store i8 %object, i8* %object.addr, align 1
  %0 = load %struct.snake_t*, %struct.snake_t** %snake.addr, align 8
  %body = getelementptr inbounds %struct.snake_t, %struct.snake_t* %0, i32 0, i32 3
  %1 = load %struct.snake_t*, %struct.snake_t** %snake.addr, align 8
  %len = getelementptr inbounds %struct.snake_t, %struct.snake_t* %1, i32 0, i32 2
  %2 = load i32, i32* %len, align 4
  %sub = sub nsw i32 %2, 1
  %idxprom = sext i32 %sub to i64
  %arrayidx = getelementptr inbounds [100 x %struct.snake_segment_t], [100 x %struct.snake_segment_t]* %body, i64 0, i64 %idxprom
  store %struct.snake_segment_t* %arrayidx, %struct.snake_segment_t** %head, align 8
  %3 = load %struct.screen_t*, %struct.screen_t** %screen.addr, align 8
  %grid = getelementptr inbounds %struct.screen_t, %struct.screen_t* %3, i32 0, i32 5
  %4 = load %struct.snake_segment_t*, %struct.snake_segment_t** %head, align 8
  %row = getelementptr inbounds %struct.snake_segment_t, %struct.snake_segment_t* %4, i32 0, i32 0
  %5 = load i32, i32* %row, align 4
  %sub1 = sub nsw i32 %5, 1
  %idxprom2 = sext i32 %sub1 to i64
  %arrayidx3 = getelementptr inbounds [22 x [78 x i8]], [22 x [78 x i8]]* %grid, i64 0, i64 %idxprom2
  %6 = load %struct.snake_segment_t*, %struct.snake_segment_t** %head, align 8
  %col = getelementptr inbounds %struct.snake_segment_t, %struct.snake_segment_t* %6, i32 0, i32 1
  %7 = load i32, i32* %col, align 4
  %sub4 = sub nsw i32 %7, 1
  %idxprom5 = sext i32 %sub4 to i64
  %arrayidx6 = getelementptr inbounds [78 x i8], [78 x i8]* %arrayidx3, i64 0, i64 %idxprom5
  %8 = load i8, i8* %arrayidx6, align 1
  %conv = sext i8 %8 to i32
  %9 = load i8, i8* %object.addr, align 1
  %conv7 = sext i8 %9 to i32
  %cmp = icmp eq i32 %conv, %conv7
  br i1 %cmp, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  store i32 1, i32* %retval, align 4
  br label %return

if.end:                                           ; preds = %entry
  store i32 0, i32* %retval, align 4
  br label %return

return:                                           ; preds = %if.end, %if.then
  %10 = load i32, i32* %retval, align 4
  ret i32 %10
}

; Function Attrs: noinline nounwind optnone uwtable
define i32 @collide_self(%struct.snake_t* %snake) #0 {
entry:
  %retval = alloca i32, align 4
  %snake.addr = alloca %struct.snake_t*, align 8
  %i = alloca i32, align 4
  %head = alloca %struct.snake_segment_t*, align 8
  %body3 = alloca %struct.snake_segment_t*, align 8
  store %struct.snake_t* %snake, %struct.snake_t** %snake.addr, align 8
  %0 = load %struct.snake_t*, %struct.snake_t** %snake.addr, align 8
  %body = getelementptr inbounds %struct.snake_t, %struct.snake_t* %0, i32 0, i32 3
  %1 = load %struct.snake_t*, %struct.snake_t** %snake.addr, align 8
  %len = getelementptr inbounds %struct.snake_t, %struct.snake_t* %1, i32 0, i32 2
  %2 = load i32, i32* %len, align 4
  %sub = sub nsw i32 %2, 1
  %idxprom = sext i32 %sub to i64
  %arrayidx = getelementptr inbounds [100 x %struct.snake_segment_t], [100 x %struct.snake_segment_t]* %body, i64 0, i64 %idxprom
  store %struct.snake_segment_t* %arrayidx, %struct.snake_segment_t** %head, align 8
  store i32 0, i32* %i, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %3 = load i32, i32* %i, align 4
  %4 = load %struct.snake_t*, %struct.snake_t** %snake.addr, align 8
  %len1 = getelementptr inbounds %struct.snake_t, %struct.snake_t* %4, i32 0, i32 2
  %5 = load i32, i32* %len1, align 4
  %sub2 = sub nsw i32 %5, 1
  %cmp = icmp slt i32 %3, %sub2
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %6 = load %struct.snake_t*, %struct.snake_t** %snake.addr, align 8
  %body4 = getelementptr inbounds %struct.snake_t, %struct.snake_t* %6, i32 0, i32 3
  %7 = load i32, i32* %i, align 4
  %idxprom5 = sext i32 %7 to i64
  %arrayidx6 = getelementptr inbounds [100 x %struct.snake_segment_t], [100 x %struct.snake_segment_t]* %body4, i64 0, i64 %idxprom5
  store %struct.snake_segment_t* %arrayidx6, %struct.snake_segment_t** %body3, align 8
  %8 = load %struct.snake_segment_t*, %struct.snake_segment_t** %head, align 8
  %row = getelementptr inbounds %struct.snake_segment_t, %struct.snake_segment_t* %8, i32 0, i32 0
  %9 = load i32, i32* %row, align 4
  %10 = load %struct.snake_segment_t*, %struct.snake_segment_t** %body3, align 8
  %row7 = getelementptr inbounds %struct.snake_segment_t, %struct.snake_segment_t* %10, i32 0, i32 0
  %11 = load i32, i32* %row7, align 4
  %cmp8 = icmp eq i32 %9, %11
  br i1 %cmp8, label %land.lhs.true, label %if.end

land.lhs.true:                                    ; preds = %for.body
  %12 = load %struct.snake_segment_t*, %struct.snake_segment_t** %head, align 8
  %col = getelementptr inbounds %struct.snake_segment_t, %struct.snake_segment_t* %12, i32 0, i32 1
  %13 = load i32, i32* %col, align 4
  %14 = load %struct.snake_segment_t*, %struct.snake_segment_t** %body3, align 8
  %col9 = getelementptr inbounds %struct.snake_segment_t, %struct.snake_segment_t* %14, i32 0, i32 1
  %15 = load i32, i32* %col9, align 4
  %cmp10 = icmp eq i32 %13, %15
  br i1 %cmp10, label %if.then, label %if.end

if.then:                                          ; preds = %land.lhs.true
  store i32 1, i32* %retval, align 4
  br label %return

if.end:                                           ; preds = %land.lhs.true, %for.body
  br label %for.inc

for.inc:                                          ; preds = %if.end
  %16 = load i32, i32* %i, align 4
  %inc = add nsw i32 %16, 1
  store i32 %inc, i32* %i, align 4
  br label %for.cond

for.end:                                          ; preds = %for.cond
  store i32 0, i32* %retval, align 4
  br label %return

return:                                           ; preds = %for.end, %if.then
  %17 = load i32, i32* %retval, align 4
  ret i32 %17
}

; Function Attrs: noinline nounwind optnone uwtable
define i32 @collision(%struct.snake_t* %snake, %struct.screen_t* %screen) #0 {
entry:
  %snake.addr = alloca %struct.snake_t*, align 8
  %screen.addr = alloca %struct.screen_t*, align 8
  store %struct.snake_t* %snake, %struct.snake_t** %snake.addr, align 8
  store %struct.screen_t* %screen, %struct.screen_t** %screen.addr, align 8
  %0 = load %struct.snake_t*, %struct.snake_t** %snake.addr, align 8
  %call = call i32 @collide_walls(%struct.snake_t* %0)
  %tobool = icmp ne i32 %call, 0
  br i1 %tobool, label %lor.end, label %lor.lhs.false

lor.lhs.false:                                    ; preds = %entry
  %1 = load %struct.snake_t*, %struct.snake_t** %snake.addr, align 8
  %2 = load %struct.screen_t*, %struct.screen_t** %screen.addr, align 8
  %call1 = call i32 @collide_object(%struct.snake_t* %1, %struct.screen_t* %2, i8 signext 42)
  %tobool2 = icmp ne i32 %call1, 0
  br i1 %tobool2, label %lor.end, label %lor.rhs

lor.rhs:                                          ; preds = %lor.lhs.false
  %3 = load %struct.snake_t*, %struct.snake_t** %snake.addr, align 8
  %call3 = call i32 @collide_self(%struct.snake_t* %3)
  %tobool4 = icmp ne i32 %call3, 0
  br label %lor.end

lor.end:                                          ; preds = %lor.rhs, %lor.lhs.false, %entry
  %4 = phi i1 [ true, %lor.lhs.false ], [ true, %entry ], [ %tobool4, %lor.rhs ]
  %lor.ext = zext i1 %4 to i32
  ret i32 %lor.ext
}

; Function Attrs: noinline nounwind optnone uwtable
define i32 @eat_gold(%struct.snake_t* %snake, %struct.screen_t* %screen) #0 {
entry:
  %snake.addr = alloca %struct.snake_t*, align 8
  %screen.addr = alloca %struct.screen_t*, align 8
  %head = alloca %struct.snake_segment_t*, align 8
  store %struct.snake_t* %snake, %struct.snake_t** %snake.addr, align 8
  store %struct.screen_t* %screen, %struct.screen_t** %screen.addr, align 8
  %0 = load %struct.snake_t*, %struct.snake_t** %snake.addr, align 8
  %body = getelementptr inbounds %struct.snake_t, %struct.snake_t* %0, i32 0, i32 3
  %1 = load %struct.snake_t*, %struct.snake_t** %snake.addr, align 8
  %len = getelementptr inbounds %struct.snake_t, %struct.snake_t* %1, i32 0, i32 2
  %2 = load i32, i32* %len, align 4
  %sub = sub nsw i32 %2, 1
  %idxprom = sext i32 %sub to i64
  %arrayidx = getelementptr inbounds [100 x %struct.snake_segment_t], [100 x %struct.snake_segment_t]* %body, i64 0, i64 %idxprom
  store %struct.snake_segment_t* %arrayidx, %struct.snake_segment_t** %head, align 8
  %3 = load %struct.screen_t*, %struct.screen_t** %screen.addr, align 8
  %grid = getelementptr inbounds %struct.screen_t, %struct.screen_t* %3, i32 0, i32 5
  %4 = load %struct.snake_segment_t*, %struct.snake_segment_t** %head, align 8
  %row = getelementptr inbounds %struct.snake_segment_t, %struct.snake_segment_t* %4, i32 0, i32 0
  %5 = load i32, i32* %row, align 4
  %sub1 = sub nsw i32 %5, 1
  %idxprom2 = sext i32 %sub1 to i64
  %arrayidx3 = getelementptr inbounds [22 x [78 x i8]], [22 x [78 x i8]]* %grid, i64 0, i64 %idxprom2
  %6 = load %struct.snake_segment_t*, %struct.snake_segment_t** %head, align 8
  %col = getelementptr inbounds %struct.snake_segment_t, %struct.snake_segment_t* %6, i32 0, i32 1
  %7 = load i32, i32* %col, align 4
  %sub4 = sub nsw i32 %7, 1
  %idxprom5 = sext i32 %sub4 to i64
  %arrayidx6 = getelementptr inbounds [78 x i8], [78 x i8]* %arrayidx3, i64 0, i64 %idxprom5
  store i8 32, i8* %arrayidx6, align 1
  %8 = load %struct.screen_t*, %struct.screen_t** %screen.addr, align 8
  %gold = getelementptr inbounds %struct.screen_t, %struct.screen_t* %8, i32 0, i32 3
  %9 = load i32, i32* %gold, align 4
  %dec = add nsw i32 %9, -1
  store i32 %dec, i32* %gold, align 4
  %10 = load %struct.snake_t*, %struct.snake_t** %snake.addr, align 8
  %len7 = getelementptr inbounds %struct.snake_t, %struct.snake_t* %10, i32 0, i32 2
  %11 = load i32, i32* %len7, align 4
  %12 = load %struct.screen_t*, %struct.screen_t** %screen.addr, align 8
  %obstacles = getelementptr inbounds %struct.screen_t, %struct.screen_t* %12, i32 0, i32 4
  %13 = load i32, i32* %obstacles, align 4
  %mul = mul nsw i32 %11, %13
  %14 = load %struct.screen_t*, %struct.screen_t** %screen.addr, align 8
  %score = getelementptr inbounds %struct.screen_t, %struct.screen_t* %14, i32 0, i32 1
  %15 = load i32, i32* %score, align 4
  %add = add nsw i32 %15, %mul
  store i32 %add, i32* %score, align 4
  %16 = load %struct.snake_t*, %struct.snake_t** %snake.addr, align 8
  %len8 = getelementptr inbounds %struct.snake_t, %struct.snake_t* %16, i32 0, i32 2
  %17 = load i32, i32* %len8, align 4
  %inc = add nsw i32 %17, 1
  store i32 %inc, i32* %len8, align 4
  %18 = load %struct.screen_t*, %struct.screen_t** %screen.addr, align 8
  %score9 = getelementptr inbounds %struct.screen_t, %struct.screen_t* %18, i32 0, i32 1
  %19 = load i32, i32* %score9, align 4
  %20 = load %struct.screen_t*, %struct.screen_t** %screen.addr, align 8
  %high_score = getelementptr inbounds %struct.screen_t, %struct.screen_t* %20, i32 0, i32 2
  %21 = load i32, i32* %high_score, align 4
  %cmp = icmp sgt i32 %19, %21
  br i1 %cmp, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  %22 = load %struct.screen_t*, %struct.screen_t** %screen.addr, align 8
  %score10 = getelementptr inbounds %struct.screen_t, %struct.screen_t* %22, i32 0, i32 1
  %23 = load i32, i32* %score10, align 4
  %24 = load %struct.screen_t*, %struct.screen_t** %screen.addr, align 8
  %high_score11 = getelementptr inbounds %struct.screen_t, %struct.screen_t* %24, i32 0, i32 2
  store i32 %23, i32* %high_score11, align 4
  br label %if.end

if.end:                                           ; preds = %if.then, %entry
  %25 = load %struct.screen_t*, %struct.screen_t** %screen.addr, align 8
  %gold12 = getelementptr inbounds %struct.screen_t, %struct.screen_t* %25, i32 0, i32 3
  %26 = load i32, i32* %gold12, align 4
  ret i32 %26
}

; Function Attrs: noinline nounwind optnone uwtable
define i32 @main() #0 {
entry:
  %retval = alloca i32, align 4
  %keypress = alloca i8, align 1
  %snake = alloca %struct.snake_t, align 4
  %screen = alloca %struct.screen_t, align 4
  %keys = alloca [7 x i8], align 1
  store i32 0, i32* %retval, align 4
  %0 = bitcast [7 x i8]* %keys to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %0, i8* getelementptr inbounds ([7 x i8], [7 x i8]* @main.keys, i32 0, i32 0), i64 7, i32 1, i1 false)
  %call = call i32 @system(i8* getelementptr inbounds ([25 x i8], [25 x i8]* @.str.14, i32 0, i32 0))
  %and = and i32 %call, 65280
  %shr = ashr i32 %and, 8
  %tobool = icmp ne i32 %shr, 0
  br i1 %tobool, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  %1 = load %struct._IO_FILE*, %struct._IO_FILE** @stderr, align 8
  %call1 = call i32 (%struct._IO_FILE*, i8*, ...) @fprintf(%struct._IO_FILE* %1, i8* getelementptr inbounds ([50 x i8], [50 x i8]* @.str.15, i32 0, i32 0))
  store i32 1, i32* %retval, align 4
  br label %return

if.end:                                           ; preds = %entry
  call void @alarm_handler(i32 0)
  %call2 = call i32 @sigsetup(i32 2, void (i32)* @sig_handler)
  %call3 = call i32 @sigsetup(i32 1, void (i32)* @sig_handler)
  %call4 = call i32 @sigsetup(i32 15, void (i32)* @sig_handler)
  br label %do.body

do.body:                                          ; preds = %do.cond41, %if.end
  call void @setup_level(%struct.screen_t* %screen, %struct.snake_t* %snake, i32 1)
  br label %do.body5

do.body5:                                         ; preds = %do.cond, %do.body
  %call6 = call i32 @getchar()
  %conv = trunc i32 %call6 to i8
  store i8 %conv, i8* %keypress, align 1
  %arraydecay = getelementptr inbounds [7 x i8], [7 x i8]* %keys, i32 0, i32 0
  %2 = load i8, i8* %keypress, align 1
  call void @move(%struct.snake_t* %snake, i8* %arraydecay, i8 signext %2)
  %call7 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([9 x i8], [9 x i8]* @.str.3, i32 0, i32 0), i32 1, i32 1)
  %call8 = call i32 @collision(%struct.snake_t* %snake, %struct.screen_t* %screen)
  %tobool9 = icmp ne i32 %call8, 0
  br i1 %tobool9, label %if.then10, label %if.else

if.then10:                                        ; preds = %do.body5
  %arrayidx = getelementptr inbounds [7 x i8], [7 x i8]* %keys, i64 0, i64 6
  %3 = load i8, i8* %arrayidx, align 1
  store i8 %3, i8* %keypress, align 1
  br label %do.end

if.else:                                          ; preds = %do.body5
  %call11 = call i32 @collide_object(%struct.snake_t* %snake, %struct.screen_t* %screen, i8 signext 36)
  %tobool12 = icmp ne i32 %call11, 0
  br i1 %tobool12, label %if.then13, label %if.end18

if.then13:                                        ; preds = %if.else
  %call14 = call i32 @eat_gold(%struct.snake_t* %snake, %struct.screen_t* %screen)
  %tobool15 = icmp ne i32 %call14, 0
  br i1 %tobool15, label %if.end17, label %if.then16

if.then16:                                        ; preds = %if.then13
  call void @setup_level(%struct.screen_t* %screen, %struct.snake_t* %snake, i32 0)
  br label %if.end17

if.end17:                                         ; preds = %if.then16, %if.then13
  call void @show_score(%struct.screen_t* %screen)
  br label %if.end18

if.end18:                                         ; preds = %if.end17, %if.else
  br label %if.end19

if.end19:                                         ; preds = %if.end18
  br label %do.cond

do.cond:                                          ; preds = %if.end19
  %4 = load i8, i8* %keypress, align 1
  %conv20 = sext i8 %4 to i32
  %arrayidx21 = getelementptr inbounds [7 x i8], [7 x i8]* %keys, i64 0, i64 6
  %5 = load i8, i8* %arrayidx21, align 1
  %conv22 = sext i8 %5 to i32
  %cmp = icmp ne i32 %conv20, %conv22
  br i1 %cmp, label %do.body5, label %do.end

do.end:                                           ; preds = %do.cond, %if.then10
  call void @show_score(%struct.screen_t* %screen)
  %call24 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([9 x i8], [9 x i8]* @.str.3, i32 0, i32 0), i32 6, i32 32)
  %call25 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([9 x i8], [9 x i8]* @.str.2, i32 0, i32 0), i32 1, i32 31)
  %call26 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([19 x i8], [19 x i8]* @.str.16, i32 0, i32 0))
  %call27 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([9 x i8], [9 x i8]* @.str.3, i32 0, i32 0), i32 9, i32 32)
  %call28 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([9 x i8], [9 x i8]* @.str.2, i32 0, i32 0), i32 1, i32 33)
  %call29 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([21 x i8], [21 x i8]* @.str.17, i32 0, i32 0))
  br label %do.body30

do.body30:                                        ; preds = %land.end, %do.end
  %call31 = call i32 @getchar()
  %conv32 = trunc i32 %call31 to i8
  store i8 %conv32, i8* %keypress, align 1
  br label %do.cond33

do.cond33:                                        ; preds = %do.body30
  %6 = load i8, i8* %keypress, align 1
  %conv34 = sext i8 %6 to i32
  %cmp35 = icmp ne i32 %conv34, 121
  br i1 %cmp35, label %land.rhs, label %land.end

land.rhs:                                         ; preds = %do.cond33
  %7 = load i8, i8* %keypress, align 1
  %conv37 = sext i8 %7 to i32
  %cmp38 = icmp ne i32 %conv37, 110
  br label %land.end

land.end:                                         ; preds = %land.rhs, %do.cond33
  %8 = phi i1 [ false, %do.cond33 ], [ %cmp38, %land.rhs ]
  br i1 %8, label %do.body30, label %do.end40

do.end40:                                         ; preds = %land.end
  br label %do.cond41

do.cond41:                                        ; preds = %do.end40
  %9 = load i8, i8* %keypress, align 1
  %conv42 = sext i8 %9 to i32
  %cmp43 = icmp eq i32 %conv42, 121
  br i1 %cmp43, label %do.body, label %do.end45

do.end45:                                         ; preds = %do.cond41
  %call46 = call i32 @puts(i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str, i32 0, i32 0))
  %call47 = call i32 @system(i8* getelementptr inbounds ([10 x i8], [10 x i8]* @.str.1, i32 0, i32 0))
  %and48 = and i32 %call47, 65280
  %shr49 = ashr i32 %and48, 8
  store i32 %shr49, i32* %retval, align 4
  br label %return

return:                                           ; preds = %do.end45, %if.then
  %10 = load i32, i32* %retval, align 4
  ret i32 %10
}

declare i32 @fprintf(%struct._IO_FILE*, i8*, ...) #2

declare i32 @getchar() #2

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { noreturn nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { argmemonly nounwind }
attributes #5 = { nounwind }
attributes #6 = { noreturn nounwind }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"clang version 6.0.0 (tags/RELEASE_600/final)"}
