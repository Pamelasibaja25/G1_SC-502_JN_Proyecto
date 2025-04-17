<?php
file_put_contents("debug_post.txt", print_r($_POST, true));
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);

require_once '../../config/database.php';

$conn = Database::connect();

// Obtener el año seleccionado, si no se envía, usar el actual
$anio = isset($_POST['anio']) ? intval($_POST['anio']) : date('Y');

// Construir condiciones según los filtros
$condiciones = [];

if (isset($_POST['reporteTrimestral'])) {
    $condiciones[] = "MONTH(n.fecha_inicio_trimestre) BETWEEN 1 AND 3 AND YEAR(n.fecha_inicio_trimestre) = $anio";
}
if (isset($_POST['reporteMensual'])) {
    $mesActual = date('n');
    $condiciones[] = "MONTH(n.fecha_inicio_trimestre) = $mesActual AND YEAR(n.fecha_inicio_trimestre) = $anio";
}
if (isset($_POST['reporteAnual'])) {
    $condiciones[] = "YEAR(n.fecha_inicio_trimestre) = $anio";
}

// Consulta base
$sql = "SELECT 
            n.fecha_inicio_trimestre AS fecha_inicio, 
            n.fecha_final_trimestre AS fecha_final, 
            c.descripcion AS nombre_curso, 
            'Finalizado' AS estado, 
            n.nota
        FROM nota n
        INNER JOIN curso c ON n.id_curso = c.id_curso";

// Si hay filtros aplicados, agregarlos a la consulta
if (!empty($condiciones)) {
    $sql .= " WHERE " . implode(" OR ", $condiciones);
}

try {
    $stmt = $conn->prepare($sql);
    $stmt->execute();
    $resultado = $stmt->fetchAll(PDO::FETCH_ASSOC);
    echo json_encode($resultado);
} catch (Exception $e) {
    http_response_code(500);
echo "ERROR: " . $e->getMessage();

}
