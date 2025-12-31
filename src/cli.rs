use clap::{Parser, Subcommand};

#[derive(Parser)]
#[command(name = "vcs", version, about = "A git-like version control system")]
struct Cli {
    #[command(subcommand)]
    command: Commands,
}

#[derive(Subcommand)]
enum Commands {
    /// Initialize a new repository
    Init,

    /// Show repository status
    Status,

    /// Commit changes
    Commit {
        /// Commit message
        #[arg(short, long)]
        message: String,
    },
}

pub fn run_cli() {
    let cli = Cli::parse();

    match cli.command {
        Commands::Init => {
            //cmd_init();
        }
        Commands::Status => {
            //cmd_status();
        }
        Commands::Commit { message } => {
            //cmd_commit(&message);
        }
    }
}
