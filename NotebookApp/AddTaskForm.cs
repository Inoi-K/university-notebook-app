using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace NotebookApp
{
    public partial class AddTaskForm : Form
    {
        TeacherForm parent;

        public AddTaskForm(TeacherForm currentForm)
        {
            InitializeComponent();

            parent = currentForm;
            List<string> courses = parent.GetCourses();
            foreach (string course in courses)
                comboBox1.Items.Add(course);
        }

        private void button2_Click(object sender, EventArgs e)
        {
            string course = comboBox1.SelectedItem as string;
            string title = textBox1.Text.Trim();
            string description = textBox2.Text.Trim();
            string deadline = textBox3.Text.Trim();

            parent.AddTask(course, title, description, deadline);
            Close();
        }
    }
}
