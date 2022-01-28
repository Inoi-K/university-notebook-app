using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using MySql.Data.MySqlClient;

namespace NotebookApp
{
    public partial class StudentForm : Form
    {
        MySqlConnection connection = new MySqlConnection("server=localhost;userid=root;password=root;database=notebook");
        MySqlCommand command;
        string query;
        string group_name;
        int student_id;
        List<string> tasks;
        Dictionary<string, bool> completedTasks = new Dictionary<string, bool>();

        void OpenConnection()
        {
            if (connection.State == ConnectionState.Closed)
                connection.Open();
        }

        void CloseConnection()
        {
            if (connection.State == ConnectionState.Open)
                connection.Close();
        }

        void Execute(string query) {
            command = new MySqlCommand(query, connection);

            try {
                OpenConnection();
                command.ExecuteNonQuery();
            }
            catch {
                MessageBox.Show("Something broke");
            }
            finally {
                CloseConnection();
            }
        }

        bool GetStringValue(string query, out string value)
        {
            value = null;
            command = new MySqlCommand(query, connection);

            try
            {
                OpenConnection();
                var result = command.ExecuteScalar();
                if (result != null)
                    value = result.ToString();
                else
                    value = "";
            }
            catch
            {
                MessageBox.Show("Something broke");
            }
            finally
            {
                CloseConnection();
            }

            return value != null;
        }

        bool GetStringValues(string query, out List<string> values) {
            values = new List<string>();

            try {
                OpenConnection();
                DataTable table = new DataTable();
                MySqlDataAdapter adapter = new MySqlDataAdapter(query, connection);
                adapter.Fill(table);
                for (int i = 0; i < table.Rows.Count; ++i)
                    values.Add(table.Rows[i][0].ToString());
            }
            catch {
                MessageBox.Show("Something broke");
            }
            finally {
                CloseConnection();
            }

            return values.Count != 0;
        }

        bool GetIntValue(string query, out int value) {
            value = -1;
            command = new MySqlCommand(query, connection);

            try {
                OpenConnection();
                var result = command.ExecuteScalar();
                if (result != null)
                    value = Convert.ToInt32(result);
            }
            catch {
                MessageBox.Show("Something broke");
            }
            finally {
                CloseConnection();
            }

            return value != -1;
        }

        bool isTaskCompleted(string taskTitle) {
            bool isCompleted = false;

            int task_id;
            string taskIDQuery = $"SELECT task_id FROM task WHERE title = '{taskTitle}'";
            GetIntValue(taskIDQuery, out task_id);

            string taskQuery = $"SELECT student_id FROM completed_task WHERE student_id = {student_id} AND task_id = {task_id}";
            command = new MySqlCommand(taskQuery, connection);

            try {
                OpenConnection();
                var result = command.ExecuteReader();
                isCompleted = result.HasRows;
            }
            catch {
                MessageBox.Show("Something broke");
            }
            finally {
                CloseConnection();
            }

            return isCompleted;
        }

        public void MarkTask(string taskTitle) {
            completedTasks[taskTitle] = true;

            int task_id;
            query = $"SELECT task_id FROM task WHERE title = '{taskTitle}'";
            GetIntValue(query, out task_id);

            query = $"INSERT INTO completed_task VALUES({student_id}, {task_id});";
            Execute(query);

            query = $"SELECT (SELECT title FROM course WHERE course_id = task.course_id) AS 'course', title, `description`, deadline FROM task WHERE course_id IN (SELECT course_id FROM group_courses WHERE group_name = '{group_name}')";
            RefreshTable();
        }

        public List<string> GetTasks() {
            return tasks;
        }

        void RefreshTable()
        {
            DataTable table = new DataTable();
            MySqlDataAdapter adapter = new MySqlDataAdapter(query, connection);
            adapter.Fill(table);
            dataGridView1.DataSource = table;
        }

        /*void ColorDeadlines() {
            for (int i = 0; i < dataGridView1.Rows.Count; ++i) {
                DateTime deadlineTime = DateTime.Parse(dataGridView1.Rows[i].Cells[3].Value.ToString());
                if (DateTime.Compare(deadlineTime, DateTime.Now) < 0) {
                    for (int j = 0; j < dataGridView1.Rows[i].Cells.Count; ++j)
                        dataGridView1.Rows[i].Cells[j].InheritedStyle.BackColor = Color.Red;
                }
            }
        }*/

        // Cells coloring
        private void dataGridView1_CellFormatting(object sender, DataGridViewCellFormattingEventArgs e) {
            if (completedTasks[dataGridView1.Rows[e.RowIndex].Cells[1].Value.ToString()]) {
                dataGridView1.Rows[e.RowIndex].Cells[e.ColumnIndex].Style.BackColor = Color.FromArgb(80, 249, 142);
            } else {
                DateTime deadlineTime = DateTime.Parse(dataGridView1.Rows[e.RowIndex].Cells[3].Value.ToString());
                if (DateTime.Compare(deadlineTime, DateTime.Now) < 0) {
                    dataGridView1.Rows[e.RowIndex].Cells[e.ColumnIndex].Style.BackColor = Color.FromArgb(249, 80, 80);
                }
            }
        }

        public StudentForm(int id)
        {
            InitializeComponent();

            student_id = id;
            string first_name, middle_name, last_name;
            query = $"SELECT first_name FROM student WHERE student_id = {student_id}";
            GetStringValue(query, out first_name);
            query = $"SELECT middle_name FROM student WHERE student_id = {student_id}";
            GetStringValue(query, out middle_name);
            query = $"SELECT last_name FROM student WHERE student_id = {student_id}";
            GetStringValue(query, out last_name);
            query = $"SELECT group_name FROM student WHERE student_id = {student_id}";
            GetStringValue(query, out group_name);

            label1.Text = last_name + " " + first_name + " " + middle_name + " " + group_name;

            query = $"SELECT title FROM task WHERE course_id IN (SELECT course_id FROM group_courses WHERE group_name = '{group_name}')";
            GetStringValues(query, out tasks);
            for (int i = 0; i < tasks.Count; ++i)
                completedTasks.Add(tasks[i], isTaskCompleted(tasks[i]));

            query = $"SELECT (SELECT title FROM course WHERE course_id = task.course_id) AS 'course', title, `description`, deadline FROM task WHERE course_id IN (SELECT course_id FROM group_courses WHERE group_name = '{group_name}')";
            RefreshTable();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            Hide();
            Form LogInForm = new LogInForm();
            LogInForm.ShowDialog();
            Close();
        }

        private void textBox1_TextChanged(object sender, EventArgs e)
        {
            query = $"SELECT (SELECT title FROM course WHERE course_id = task.course_id) AS 'course', title, `description`, deadline FROM task WHERE(course_id IN(SELECT course_id FROM group_courses WHERE group_name = '{group_name}') AND(title LIKE '%{textBox1.Text}%' OR `description` LIKE '%{textBox1.Text}%'))";
            RefreshTable();
        }

        private void button2_Click(object sender, EventArgs e) {
            Form MarkTaskForm = new MarkTaskForm(this);
            MarkTaskForm.ShowDialog();
        }
    }
}
