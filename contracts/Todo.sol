pragma solidity >=0.4.22 <0.9.0;

contract Todo
{
    struct Task{

        uint id;
        uint date;
        string content;
        string author;
        bool done;
        uint dateComplete;


    }

    mapping(uint=>Task) public tasks;

    uint public nextTasksId;




    event TaskCreated (
        uint id,
        uint date,
        string content,
        string author,
        bool done
    );

    event TaskStatusToggled(
        uint id,
        bool done,
        uint date
    );



    function createTask(
        string memory _content,
        string memory _author
    ) external{
        tasks[nextTasksId] = Task(nextTasksId, block.timestamp, _content, _author, false, 0);
        emit TaskCreated(nextTasksId, block.timestamp, _content, _author, false);
        nextTasksId++;
    }


    function getTasks() external view returns(Task[] memory)
    {
        Task[] memory _tasks = new Task[](nextTasksId);
        for(uint i=0; i< nextTasksId; i++)
        {
            _tasks[i]=tasks[i];
        }
        return _tasks;
    }


    function toggleDone(uint id) external {
        require(tasks[id].id != 0, 'task does not exist');
        Task storage task= tasks[id];
        task.done = !task.done;
        task.dateComplete = task.done ? block.timestamp : 0;
        emit TaskStatusToggled(id, task.done, task.dateComplete);
    }

  
}