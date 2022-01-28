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
    public partial class TeacherForm : Form
    {
        MySqlConnection connection = new MySqlConnection("server=localhost;userid=root;password=root;database=notebook");
        MySqlCommand command;
        string query;
        int teacher_id;
        bool isTask = true;
        List<string> courses;

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

        bool GetIntValue(string query, out int value)
        {
            value = -1;
            command = new MySqlCommand(query, connection);

            try
            {
                OpenConnection();
                var result = command.ExecuteScalar();
                if (result != null)
                    value = Convert.ToInt32(result);
            }
            catch
            {
                MessageBox.Show("Something broke");
            }
            finally
            {
                CloseConnection();
            }

            return value != -1;
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

        void Execute(string query)
        {
            command = new MySqlCommand(query, connection);

            try
            {
                OpenConnection();
                command.ExecuteNonQuery();
            }
            catch
            {
                MessageBox.Show("Something broke");
            }
            finally
            {
                CloseConnection();
            }
        }

        void RefreshTable()
        {
            DataTable table = new DataTable();
            MySqlDataAdapter adapter = new MySqlDataAdapter(query, connection);
            adapter.Fill(table);
            dataGridView1.DataSource = table;
        }

        public List<string> GetCourses() {
            return courses;
        }

        public void AddTask(string course, string title, string description, string deadline)
        {
            int last_task_id;
            query = $"SELECT task_id FROM task ORDER BY task_id DESC";
            GetIntValue(query, out last_task_id);

            int course_id;
            query = $"SELECT course_id FROM course WHERE title = '{course}'";
            GetIntValue(query, out course_id);

            query = $"INSERT INTO task VALUES({course_id}, {last_task_id + 1}, '{title}', '{description}', '{deadline}')";
            Execute(query);

            ShowTasks();
        }

        void ShowStudents()
        {
            isTask = false;
            query = $"SELECT first_name, middle_name, last_name, group_name, gpa FROM student WHERE group_name IN (SELECT group_name FROM group_courses WHERE course_id IN (SELECT course_id FROM teacher_courses WHERE teacher_id = {teacher_id}))";
            RefreshTable();
        }

        void ShowTasks()
        {
            isTask = true;
            query = $"SELECT (SELECT title FROM course WHERE course_id = task.course_id) AS 'course', title, `description`, deadline FROM task WHERE course_id IN (SELECT course_id FROM teacher_courses WHERE teacher_id = {teacher_id})";
            RefreshTable();
        }

        public TeacherForm(int id)
        {
            InitializeComponent();

            teacher_id = id;
            string first_name, middle_name, last_name;
            query = $"SELECT first_name FROM teacher WHERE teacher_id = {teacher_id}";
            GetStringValue(query, out first_name);
            query = $"SELECT middle_name FROM teacher WHERE teacher_id = {teacher_id}";
            GetStringValue(query, out middle_name);
            query = $"SELECT last_name FROM teacher WHERE teacher_id = {teacher_id}";
            GetStringValue(query, out last_name);

            label1.Text = last_name + " " + first_name + " " + middle_name;

            query = $"SELECT title FROM course WHERE course_id IN (SELECT course_id FROM teacher_courses WHERE teacher_id = {teacher_id})";
            GetStringValues(query, out courses);

            ShowTasks();
        }

        private void button2_Click(object sender, EventArgs e)
        {
            Form AddTaskForm = new AddTaskForm(this);
            AddTaskForm.ShowDialog();
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
            if (isTask)
                query = $"SELECT (SELECT title FROM course WHERE course_id = task.course_id) as 'course', title, `description`, deadline FROM task WHERE (course_id IN (SELECT course_id FROM teacher_courses WHERE teacher_id = {teacher_id}) AND (title LIKE '%{textBox1.Text}%' OR `description` LIKE '%{textBox1.Text}%'))";
            else
                query = $"SELECT first_name, middle_name, last_name, group_name, gpa FROM student WHERE ((group_name IN (SELECT group_name FROM group_courses WHERE course_id IN (SELECT course_id FROM teacher_courses WHERE teacher_id = {teacher_id}))) AND (first_name LIKE '%{textBox1.Text}%' OR middle_name LIKE '%{textBox1.Text}%' or last_name LIKE '%{textBox1.Text}%'))";
            RefreshTable();
        }

        private void button4_Click(object sender, EventArgs e)
        {
            ShowStudents();
        }

        private void button3_Click(object sender, EventArgs e)
        {
            ShowTasks();
        }
    }
}
