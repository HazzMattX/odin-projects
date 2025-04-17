package main
import "core:fmt"
import "core:math/rand"
TERRAIN_WIDTH  :: 100
TERRAIN_HEIGHT :: 50
terrain_map: [TERRAIN_HEIGHT][TERRAIN_WIDTH]int
main :: proc() {
    generate_terrain()
    print_terrain()
}
generate_terrain :: proc() {
    for y := 0; y < TERRAIN_HEIGHT; y += 1 {
        for x := 0; x < TERRAIN_WIDTH; x += 1 {
            terrain_map[y][x] = int(rand.int31_max(10))
        }
    }
}
get_terrain_char :: proc(height: int) -> rune {
    if height <= 2  { return '~' }  // Water
    if height <= 5  { return '.' }  // Grass
    if height <= 7  { return ',' }  // Hills
    return '#'                      // Mountains
}
print_terrain :: proc() {
    for y := 0; y < TERRAIN_HEIGHT; y += 1 {
        for x := 0; x < TERRAIN_WIDTH; x += 1 {
            fmt.print(get_terrain_char(terrain_map[y][x]))
        }
        fmt.println("")  // Newline after each row
    }
}
