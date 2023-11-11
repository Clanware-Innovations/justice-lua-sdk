
declare type HttpMethod = "GET" | "POST" | "PUT" | "PATCH" | "DELETE";

declare interface CwRequest {
  endpoint: string;
  method: HttpMethod;
  body?: { [key: string]: any };
  params?: { [key: string]: any };
}

declare type CwResponse = boolean | { Body?: string, Headers: { [index: string]: string }, StatusCode: number, StatusMessage: string, Success: boolean }

declare type CaseStatus = "published" | "archived";

declare interface IndexedCase {
  case_id: number;
  status: CaseStatus;
  date_updated: string;
  date_created: string;
  end_date: string;
  evidence: number[];
  alts: number[];
  account_sharing: number[];
}

declare interface ListCasesParams {
  page?: number;
  limit?: number;
  showArchived?: boolean;
}

declare interface SearchBody {
  robloxIds?: string[];
  discordIds?: string[];
  robloxUsernames?: string[];
  showArchived?: boolean;
}

declare interface ClanwareService {
  /**
   * The apiToken of the service.
   */
  apiToken: string;
  /**
   * Calls `GET /justice/degenerates`
   */
  listDegenerates(params?: ListCasesParams): CwResponse;
  /**
   * Calls `GET /justice/exploiters`
   */
  listExploiters(params?: ListCasesParams): CwResponse;
  /**
   * Calls `GET /justice/degenerates/:caseId`
   */
  getDegenerate(caseId: number, params?: { showArchived: boolean }): CwResponse;
  /**
   * Calls `GET /justice/exploiters/:caseId`
   */
  getExploiter(caseId: number, params?: { showArchived: boolean }): CwResponse;
  /**
   * Calls `POST /justice/degenerates`
   */
  searchDegenerates(body: SearchBody): CwResponse;
  /**
   * Calls `POST /justice/exploiters`
   */
  searchExploiters(body: SearchBody): CwResponse;
  /**
   * Calls `POST /justice/legacy/:robloxId`
   */
  checkLegacy(robloxId: number): CwResponse;
}

declare interface ClanwareServiceFactory {
  /**
   * Returns the singleton instance of the ClanwareService.
   * @requires apiToken is required for the first call. This can be generated via `/token` using the Clanware discord bot.
   */
  getInstance(apiToken?: string): ClanwareService;
}

/**
 * Creates a factory for the ClanwareService.
 */
declare function createClanwareService(): ClanwareServiceFactory;