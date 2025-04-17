package main
import rl "vendor:raylib"
Vec2i :: [2]int
position: Vec2i
move_direction: Vec2i
move_speed: int = 5
Player :: struct {
    x: int,
    y: int,
}

main :: proc() {
    rl.InitWindow(800, 600, "Bent, Not Broken")
    rl.SetTargetFPS(60)
    player := Player {
        x = position.x,
        y = position.y
    }
    // Main game loop
    for !rl.WindowShouldClose() {
        if rl.IsGamepadButtonDown(0, .LEFT_FACE_RIGHT) {
            player.x += move_speed
        }
        rl.BeginDrawing()
        defer rl.EndDrawing()
        rl.ClearBackground(rl.RAYWHITE)
        rl.DrawRectangle(i32(player.x), i32(player.y), 20, 20, rl.BLUE)
    }

    // De-initialization
    rl.CloseWindow()
}
