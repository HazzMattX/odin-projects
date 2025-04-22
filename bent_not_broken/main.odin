package main
import "core:fmt"
import "core:os"
import "core:time"
import rl "vendor:raylib"
Vec2i :: [2]int
position: Vec2i
move_speed: int = 5
max_speed: int = 20
moving: bool

Player :: struct {
    x: int,
    y: int,
}

main :: proc() {
    rl.InitWindow(800, 600, "Bent, Not Broken")
    rl.SetTargetFPS(60)
    moving = false
    player := Player {
        x = position.x,
        y = position.y
    }
    player.x = 400
    player.y = 300
    // Main game loop
    for !rl.WindowShouldClose() {
        if rl.IsGamepadButtonDown(0, .LEFT_FACE_RIGHT) || rl.IsKeyDown(.RIGHT) || rl.GetGamepadAxisMovement(0, .LEFT_X) > 0.25 {
            moving = true
            player.x += move_speed
        } else if rl.IsGamepadButtonDown(0, .LEFT_FACE_LEFT) || rl.IsKeyDown(.LEFT) || rl.GetGamepadAxisMovement(0, .LEFT_X) < -0.25 {
            moving = true
            player.x -= move_speed
        } else {
            moving = false
            if !moving {
                move_speed = 0
            }
        }
        if moving {
            time.sleep(100*time.Millisecond)
            move_speed += 1
            if move_speed > max_speed {
                move_speed = max_speed
            }
        }
        rl.BeginDrawing()
        defer rl.EndDrawing()
        rl.ClearBackground(rl.RAYWHITE)
        rl.DrawRectangle(i32(player.x), i32(player.y), 20, 20, rl.BLUE)
    }

    // De-initialization
    rl.CloseWindow()
}
