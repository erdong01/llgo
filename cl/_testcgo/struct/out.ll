; ModuleID = 'main'
source_filename = "main"

%main.Foo = type { i32, i1 }

@main.format = global ptr null
@"main.init$guard" = global ptr null

define void @"(main.Foo).Print"(%main.Foo %0) {
_llgo_0:
  %1 = alloca %main.Foo, align 8
  store %main.Foo %0, ptr %1, align 4
  %2 = getelementptr inbounds %main.Foo, ptr %1, i32 0, i32 1
  %3 = load i1, ptr %2, align 1
  br i1 %3, label %_llgo_1, label %_llgo_2

_llgo_1:                                          ; preds = %_llgo_0
  %4 = getelementptr inbounds %main.Foo, ptr %1, i32 0, i32 0
  %5 = load i32, ptr %4, align 4
  call void (ptr, ...) @printf(ptr @main.format, i32 %5)
  br label %_llgo_2

_llgo_2:                                          ; preds = %_llgo_1, %_llgo_0
  ret void
}

define void @"(*main.Foo).Print"(ptr %0) {
_llgo_0:
  %1 = load %main.Foo, ptr %0, align 4
  call void @"(main.Foo).Print"(%main.Foo %1)
  ret void
}

define void @main.init() {
_llgo_0:
  %0 = load i1, ptr @"main.init$guard", align 1
  br i1 %0, label %_llgo_2, label %_llgo_1

_llgo_1:                                          ; preds = %_llgo_0
  store i1 true, ptr @"main.init$guard", align 1
  store i8 72, ptr @main.format, align 1
  store i8 101, ptr getelementptr inbounds (i8, ptr @main.format, i64 1), align 1
  store i8 108, ptr getelementptr inbounds (i8, ptr @main.format, i64 2), align 1
  store i8 108, ptr getelementptr inbounds (i8, ptr @main.format, i64 3), align 1
  store i8 111, ptr getelementptr inbounds (i8, ptr @main.format, i64 4), align 1
  store i8 32, ptr getelementptr inbounds (i8, ptr @main.format, i64 5), align 1
  store i8 37, ptr getelementptr inbounds (i8, ptr @main.format, i64 6), align 1
  store i8 100, ptr getelementptr inbounds (i8, ptr @main.format, i64 7), align 1
  store i8 10, ptr getelementptr inbounds (i8, ptr @main.format, i64 8), align 1
  store i8 0, ptr getelementptr inbounds (i8, ptr @main.format, i64 9), align 1
  br label %_llgo_2

_llgo_2:                                          ; preds = %_llgo_1, %_llgo_0
  ret void
}

define void @main() {
_llgo_0:
  call void @main.init()
  %0 = alloca %main.Foo, align 8
  %1 = getelementptr inbounds %main.Foo, ptr %0, i32 0, i32 0
  %2 = getelementptr inbounds %main.Foo, ptr %0, i32 0, i32 1
  store i32 100, ptr %1, align 4
  store i1 true, ptr %2, align 1
  %3 = load %main.Foo, ptr %0, align 4
  call void @"(main.Foo).Print"(%main.Foo %3)
  ret void
}

declare void @printf(ptr, ...)
