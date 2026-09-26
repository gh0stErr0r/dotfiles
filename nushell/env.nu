$env.config = {
    show_banner: false

    edit_mode: emacs

    history: {
        file_format: sqlite
        max_size: 100000
        sync_on_enter: true
    }

    cursor_shape: {
        emacs: line
        vi_insert: line
        vi_normal: block
    }

    completions: {
        case_sensitive: false
        quick: true
        partial: true
        algorithm: fuzzy
    }
}


$env.EDITOR = "helix"
$env.VISUAL = "helix"


$env.GOPATH = $"($env.HOME)/go"

$env.PATH = (
    $env.PATH
    | prepend $"($env.HOME)/.cargo/bin"
    | prepend $"($env.HOME)/go/bin"
    | prepend $"($env.HOME)/zig"
    | prepend $"($env.HOME)/.bun/bin"
)

