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
    public partial class LogInForm : Form
    {
        MySqlConnection connection = new MySqlConnection("server=localhost;userid=root;password=root;database=notebook");
        MySqlCommand command;
        string query;

        public LogInForm()
        {
            InitializeComponent();
            /*OpenConnection();
            command = new MySqlCommand("SELECT `password` FROM student WHERE last_name = 'l test'", connection);
            MessageBox.Show(command.ExecuteScalar().ToString());
            CloseConnection();*/
        }

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

        private void button1_Click(object sender, EventArgs e)
        {
            string login = textBox1.Text.Trim();
            string password = textBox2.Text.Trim();
            string result;

            query = $"SELECT `password` FROM student WHERE last_name = '{login}'";
            if (GetStringValue(query, out result))
            {
                if (password == result.ToString())
                {
                    int id;
                    query = $"SELECT student_id FROM student WHERE `password` = '{password}'";
                    GetIntValue(query, out id);
                    
                    Hide();
                    Form studentForm = new StudentForm(id);
                    studentForm.ShowDialog();
                    Close();
                }
                else
                {
                    MessageBox.Show("Wrong password");
                }
            }
            else
            {
                query = $"SELECT `password` FROM teacher WHERE last_name = '{login}'";
                if (GetStringValue(query, out result))
                {
                    if (password == result)
                    {
                        int id;
                        query = $"SELECT teacher_id FROM teacher WHERE (last_name = '{login}' AND `password` = '{password}')";
                        GetIntValue(query, out id);

                        Hide();
                        Form teacherForm = new TeacherForm(id);
                        teacherForm.ShowDialog();
                        Close();
                    }
                }
                else
                    MessageBox.Show("There is no such user. Check your inputs");
            }
        }
    }
}
