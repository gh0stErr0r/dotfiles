def battery [] {
    try {
        let info = (^acpi -b | str trim)

        let percent = (
            $info
            | parse "{state}, {percent}%, {rest}"
            | first
            | get percent
        )

        let state = (
            $info
            | parse "{state}, {percent}%, {rest}"
            | first
            | get state
        )

        if ($state | str contains "Charging") {
            $"($percent)%"
        } else {
            $"($percent)%"
        }

    } catch {
        ""
    }
}


def git_info [] {
    let branch = (
        ^git branch --show-current
        | complete
    )

    if $branch.exit_code != 0 {
        return ""
    }

    let name = ($branch.stdout | str trim)

    let dirty = (
        ^git status --porcelain
        | complete
    )

    if ($dirty.stdout | str trim | is-empty) {
        $"git:($name)"
    } else {
        $"git:($name)*"
    }
}

def c_red [text] {
    $"(ansi red)($text)(ansi reset)"
}

def c_blue [text] {
    $"(ansi blue)($text)(ansi reset)"
}

def c_bold_red [text] {
    $"(ansi red_bold)($text)(ansi reset)"
}


$env.PROMPT_COMMAND = {

    let time = (date now | format date "%H:%M:%S")
    let bat = battery
    let git = git_info


    let top = [
        (c_bold_red "┌─[")
        "λ"
        (c_bold_red "]")
        "-"
        (c_blue $"[($time)]")
        "-"
        $"[($bat)]"
        "-"
        $"[($git)]"
    ] | str join


    let bottom = [
        (c_bold_red "└─[")
        (c_blue $env.PWD)
        (c_bold_red "]")
        " > "
    ] | str join


    [
        $top
        $bottom
    ] | str join "\n"
}

$env.PROMPT_INDICATOR = ""
$env.PROMPT_COMMAND_RIGHT = ""
