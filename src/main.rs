use pyo3::prelude::*;
use pyo3::types::PyModule;
use std::fs;

fn main() -> PyResult<()> {
    // Trova la cartella del binario (target/release o target/debug)
    let mut exe_dir = std::env::current_exe().unwrap();
    exe_dir.pop(); // rimuove il nome del binario

    // Percorso a python/main.py accanto al binario
    let main_py_path = exe_dir.join("python").join("main.py");

    // Leggi il file Python
    let code = fs::read_to_string(&main_py_path)
        .expect("Impossibile leggere main.py");

    Python::with_gil(|py| {
        // Importa sys con API moderna
        let sys = PyModule::import_bound(py, "sys")?;

        // sys.path.append("path/to/python")
        let sys_path = sys.getattr("path")?;
        sys_path.call_method1("append", (exe_dir.join("python").to_str().unwrap(),))?;

        // Crea il modulo Python dal codice
        let module = PyModule::from_code_bound(py, &code, "main.py", "main")?;

        // Esegui la funzione main() se esiste
        if let Ok(func) = module.getattr("main") {
            func.call0()?;
        } else {
            println!("main() non trovata in main.py");
        }

        println!("Python eseguito con successo.");
        Ok(())
    })
}
