class CountData {
  Count? count;

  CountData({
    this.count,
  });

  CountData.fromJson(Map<String, dynamic> json) {
    count = json['count'] != null ? new Count.fromJson(json['count']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.count != null) {
      data['count'] = this.count!.toJson();
    }

    return data;
  }
}

class Count {
  int? tasksCount;
  int? pendingCount;
  int? taxPayableCount;
  int? totalOverdueTaskCount;
  int? totalQueryRaisedCount;
  int? unassignedTaskCount;
  int? totalOnBoardCount;
  int? unpaidTaskBoardCount;

  Count(
      {this.tasksCount,
      this.pendingCount,
      this.taxPayableCount,
      this.totalOverdueTaskCount,
      this.totalQueryRaisedCount,
      this.unassignedTaskCount,
      this.totalOnBoardCount,
      this.unpaidTaskBoardCount});

  Count.fromJson(Map<String, dynamic> json) {
    tasksCount = json['tasks_count'];
    pendingCount = json['pending_count'];
    taxPayableCount = json['tax_payable_count'];
    totalOverdueTaskCount = json['total_overdue_task_count'];
    totalQueryRaisedCount = json['total_query_raised_count'];
    unassignedTaskCount = json['unassigned_task_count'];
    totalOnBoardCount = json['total_on_board_count'];
    unpaidTaskBoardCount = json['unpaid_task_board_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tasks_count'] = this.tasksCount;
    data['pending_count'] = this.pendingCount;
    data['tax_payable_count'] = this.taxPayableCount;
    data['total_overdue_task_count'] = this.totalOverdueTaskCount;
    data['total_query_raised_count'] = this.totalQueryRaisedCount;
    data['unassigned_task_count'] = this.unassignedTaskCount;
    data['total_on_board_count'] = this.totalOnBoardCount;
    data['unpaid_task_board_count'] = this.unpaidTaskBoardCount;
    return data;
  }
}
