const foo = @cImport(
    {
        @cInclude("foo.h");
    }
);

pub fn add_four(i: i32) i32 {
    return foo.adds_two(foo.adds_two(i));
}
